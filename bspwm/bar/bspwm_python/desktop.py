from enum import Enum, auto
from collections import namedtuple

class State(Enum):
    FOCUSED = auto()
    ACTIVE = auto()
    UNFOCUSED = auto()

class Status(Enum):
    OCCUPIED = auto()
    UNOCCUPIED = auto()
    URGENT = auto()

class Layout(Enum):
    TILED = auto()
    MONOCLE = auto()

Desktop = namedtuple('Desktop', ['name', 'state', 'status'])
