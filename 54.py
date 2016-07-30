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

    def __init__(self, *args, **kwargs):
        self.flavor = self.high_card
        self.comparison_key = (self.royal_flush[0], 9, 8, 7, 6, 5)


def evaluate_hand(hand):
    return Evaluation()


def test_evaluate_high_card():
    hand = '8C TS KC 9H 4S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.high_card
    assert value.comparison_key == (Evaluation.k, Evaluation.t, 9, 8, 4)


def test_evaluate_two_pair():
    hand = '8C TS TC 8H 4S'
    value = evaluate_hand(hand)
    assert value.flavor == Evaluation.two_pairs
    assert value.comparison_key == (Evaluation.t, 8, 4)
