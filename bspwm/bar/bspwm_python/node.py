from enum import Enum, auto

class State(Enum):
    TILED = auto()
    PSEUDO_TILED = auto()
    FLOATING = auto()
    FULLSCREEN = auto()

class Flag(Enum):
    HIDDEN = auto()
    STICKY = auto()
    PRIVATE = auto()
    LOCKED = auto()
    URGENT = auto()
