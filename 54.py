import collections

class Evaluation:
    # Types of poker hands, least-valuable first.
    high_card       = '0_high_card'
    one_pair        = '1_one_pair'
    two_pairs       = '2_two_pairs'
    three_of_a_kind = '3_three_of_a_kind'
    straight        = '4_straight'
    flush           = '5_flush'
    full_house      = '6_full_house'
    four_of_a_kind  = '7_four_of_a_kind'
    straight_flush  = '8_straight_flush'
    royal_flush     = '9_royal_flush'

    # Shorthands for non-numeric cards
    t = 10
    j = 11
    q = 12
    k = 13
    a = 14

    def __init__(self):
        self.flavor = None
        self.comparison_key = ()

    def __repr__(self):
        return repr(self.__dict__)


def rank(card):
    first_letter = card[0]
    if first_letter.isdigit():
        return int(first_letter)
    return {
        't': 10,
        'j': 11,
        'q': 12,
        'k': 13,
        'a': 14
        }[first_letter.lower()]


def suit(card):
    return card[1].lower()


def is_flush(cards):
    suits = [suit(c) for c in cards]
    return len(set(suits)) == 1


def is_straight(cards):
    ranks = [rank(c) for c in cards]
    if len(ranks) != len(cards):
        return False

    return max(ranks) - min(ranks) == len(ranks) - 1


def evaluate_hand(hand):
    e = Evaluation()
    cards = hand.split()
    ranks = [rank(c) for c in cards]
    suits = [suit(c) for c in cards]

    by_ranks = collections.defaultdict(set)
    for c in cards:
        by_ranks[rank(c)].add(suit(c))
    rank_histogram = {k: len(v) for k, v in by_ranks.items()}
    shape = sorted(rank_histogram.values(), reverse=True)
    ranks_by_number_of_occurrences = {v: k for k, v in rank_histogram.items()}

    if is_straight(cards) and is_flush(cards):
        if max(ranks) == Evaluation.a:
            e.flavor = e.royal_flush
        else:
            e.flavor = e.straight_flush
            e.comparison_key = max(ranks)
    elif set(rank_histogram.values()) == set([1, 4]):
        e.flavor = e.four_of_a_kind
        e.comparison_key = (ranks_by_number_of_occurrences[4], ranks_by_number_of_occurrences[1])
    elif set(rank_histogram.values()) == set([2, 3]):
        e.flavor = e.full_house
        e.comparison_key = (ranks_by_number_of_occurrences[3], ranks_by_number_of_occurrences[2])
    elif len(set(suits)) == 1:
        e.flavor = e.flush
        e.comparison_key = tuple(sorted(ranks, reverse=True))
    elif is_straight(cards):
        e.flavor = e.straight
        e.comparison_key = tuple(sorted(ranks, reverse=True))
    elif 3 in ranks_by_number_of_occurrences:
        r = ranks_by_number_of_occurrences.pop(3)
        rank_histogram.pop(r)
        e.flavor = e.three_of_a_kind
        e.comparison_key = tuple([r] + sorted(rank_histogram.keys(), reverse=True))
    elif shape == [2, 2, 1]:
        ranks_of_pairs = [r for r, cards in by_ranks.items() if len(cards) == 2]
        e.flavor = e.two_pairs
        e.comparison_key = tuple(sorted(ranks_of_pairs, reverse=True)
                                 + [ranks_by_number_of_occurrences[1]])
    elif shape == [2, 1, 1, 1]:
        r = ranks_by_number_of_occurrences.pop(2)
        rank_histogram.pop(r)
        e.flavor = e.one_pair
        e.comparison_key = tuple([r] + sorted(rank_histogram.keys(), reverse=True))
    else:
        e.flavor = e.high_card
        e.comparison_key = tuple(sorted(ranks, reverse=True))

    return e


def test_evaluate_high_card():
    hand = '8C TS KC 9H 4S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.high_card
    assert value.comparison_key == (Evaluation.k, Evaluation.t, 9, 8, 4)


def test_evaluate_one_pair():
    hand = '8C TS KC 9H 8S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.one_pair
    assert value.comparison_key == (8, Evaluation.k, Evaluation.t, 9)


def test_evaluate_two_pair():
    hand = '8C TS TC 8H 4S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.two_pairs
    assert value.comparison_key == (Evaluation.t, 8, 4)


def test_evaluate_three_of_a_kind():
    hand = '8C TS 9C 8H 8S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.three_of_a_kind
    assert value.comparison_key == (8, Evaluation.t, 9)


def test_evaluate_straight():
    hand = '8C TS 9C QH JS'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.straight
    assert value.comparison_key == (Evaluation.q, Evaluation.j, Evaluation.t, 9, 8)


def test_evaluate_flush():
    hand = '8C TC 2C QC JC'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.flush
    assert value.comparison_key == (Evaluation.q, Evaluation.j, Evaluation.t, 8, 2)


def test_evaluate_full_house():
    hand = '8C 8S 8D 2C 2H'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.full_house
    assert value.comparison_key == (8, 2)


def test_evaluate_four_of_a_kind():
    hand = '8C 8S 8D 8H 2H'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.four_of_a_kind
    assert value.comparison_key == (8, 2)


def test_evaluate_straight_flush():
    hand = '8H 7H 6H 5H 4H'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.straight_flush
    assert value.comparison_key == (8)


def test_evaluate_royal_flush():
    hand = 'AH QH TH KH JH'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.royal_flush
    assert value.comparison_key == ()
