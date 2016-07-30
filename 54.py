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


def is_flush(hand):
    cards = hand.split()
    suits = [suit(c) for c in cards]
    return len(set(suits)) == 1


def is_straight(hand):
    cards = hand.split()
    ranks = [rank(c) for c in cards]
    if len(ranks) != len(cards):
        return False

    return max(ranks) - min(ranks) == len(ranks) - 1


def evaluate_hand(hand):
    e = Evaluation()
    if is_straight(hand) and is_flush(hand):
        cards = hand.split()
        ranks = [rank(c) for c in cards]
        if max(ranks) == Evaluation.a:
            e.flavor = e.royal_flush

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
    assert value.comparison_key == (8, Evaluation.t)


def test_evaluate_straight():
    hand = '8C TS 9C QH JS'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.straight
    assert value.comparison_key == (Evaluation.q)


def test_evaluate_flush():
    hand = '8C TC 2C QC JC'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.flush
    assert value.comparison_key == (Evaluation.q)


def test_evaluate_full_house():
    hand = '8C 8S 8D 2C 2H'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.full_house
    assert value.comparison_key == (8)


def test_evaluate_four_of_a_kind():
    hand = '8C 8S 8D 8H 2H'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.four_of_a_kind
    assert value.comparison_key == (8)


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
