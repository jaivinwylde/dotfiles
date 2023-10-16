# pyright: reportMissingImports=false
import datetime

from kitty.fast_data_types import Screen
from kitty.tab_bar import ExtraData, as_rgb, DrawData, TabBarData, draw_title
from kitty.utils import color_as_int


def draw_right_status(screen: Screen, is_last: bool) -> int:
    end = screen.cursor.x
    if not is_last:
        return end

    # Create date string
    date = datetime.datetime.now().strftime("%H:%M")
    right_length = len(date)

    # Draw padding to draw stuff to the right
    draw_spaces = screen.columns - screen.cursor.x - right_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    # Draw date
    screen.cursor.fg = as_rgb(color_as_int(0x00FFD7))
    screen.cursor.bold = True
    screen.draw(date)
    # Remove date length from padding
    if screen.columns - screen.cursor.x > right_length:
        screen.cursor.x = screen.columns - right_length

    return end


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if index > 1:
        # Tab spacing
        screen.draw(draw_data.sep)

    draw_title(draw_data, screen, tab, index)
    draw_right_status(screen, is_last)

    return screen.cursor.x
