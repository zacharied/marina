from enum import Enum, auto

from collections import namedtuple

class State(Enum):
    FOCUSED = auto()
    UNFOCUSED = auto()

Monitor = namedtuple('Monitor', ['index', 'name', 'state'])
