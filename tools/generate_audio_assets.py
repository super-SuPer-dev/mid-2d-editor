"""Generate small deterministic chiptune SFX used by the runtime audio pilot."""

from __future__ import annotations

import math
import os
import random
import wave
from pathlib import Path


RATE = 22050
OUT_DIR = Path(__file__).resolve().parents[1] / "assets" / "audio" / "generated"


def envelope(t: float, duration: float, attack: float = 0.005, release: float = 0.04) -> float:
    if t < attack:
        return t / max(attack, 1e-6)
    if t > duration - release:
        return max(0.0, (duration - t) / max(release, 1e-6))
    return 1.0


def osc(freq: float, t: float, kind: str = "square") -> float:
    phase = (freq * t) % 1.0
    if kind == "saw":
        return phase * 2.0 - 1.0
    if kind == "triangle":
        return 1.0 - 4.0 * abs(phase - 0.5)
    return 1.0 if phase < 0.5 else -1.0


def render(duration: float, fn, seed: int) -> list[int]:
    rng = random.Random(seed)
    samples: list[int] = []
    for index in range(int(duration * RATE)):
        t = index / RATE
        samples.append(max(-32767, min(32767, int(fn(t, duration, rng) * 28000.0))))
    return samples


def write_wav(name: str, samples: list[int]) -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    with wave.open(str(OUT_DIR / name), "wb") as stream:
        stream.setnchannels(1)
        stream.setsampwidth(2)
        stream.setframerate(RATE)
        stream.writeframes(b"".join(int(sample).to_bytes(2, "little", signed=True) for sample in samples))


def cutter(t: float, d: float, _rng: random.Random) -> float:
    f = 980.0 - 600.0 * (t / d)
    return 0.52 * osc(f, t, "saw") * envelope(t, d, 0.002, 0.07) + 0.18 * math.sin(2.0 * math.pi * 1550.0 * t) * envelope(t, d, 0.001, 0.03)


def hurt(t: float, d: float, _rng: random.Random) -> float:
    f = 250.0 - 120.0 * (t / d)
    return 0.48 * osc(f, t) * envelope(t, d, 0.003, 0.08) + 0.12 * math.sin(2.0 * math.pi * 90.0 * t) * envelope(t, d, 0.002, 0.1)


def enemy_hit(t: float, d: float, rng: random.Random) -> float:
    return (0.32 * (rng.random() * 2.0 - 1.0) + 0.2 * osc(120.0, t, "triangle")) * envelope(t, d, 0.001, 0.06)


def pickup(t: float, d: float, _rng: random.Random) -> float:
    notes = (659.25, 783.99, 987.77)
    slot = min(2, int(t / (d / 3.0)))
    local_t = t - slot * d / 3.0
    return 0.38 * osc(notes[slot], local_t, "triangle") * envelope(local_t, d / 3.0, 0.002, 0.06)


def dash(t: float, d: float, rng: random.Random) -> float:
    f = 180.0 + 900.0 * (t / d)
    return (0.28 * osc(f, t, "saw") + 0.12 * (rng.random() * 2.0 - 1.0)) * envelope(t, d, 0.002, 0.07)


def boss_defeat(t: float, d: float, _rng: random.Random) -> float:
    notes = (392.0, 329.63, 261.63, 196.0)
    slot = min(3, int(t / (d / 4.0)))
    local_t = t - slot * d / 4.0
    return 0.42 * osc(notes[slot], local_t, "triangle") * envelope(local_t, d / 4.0, 0.006, 0.12)


def radio_beep(t: float, d: float, _rng: random.Random) -> float:
    return 0.34 * math.sin(2.0 * math.pi * 880.0 * t) * envelope(t, d, 0.004, 0.03)


def music_loop(t: float, _d: float, _rng: random.Random, root: float, mode: int) -> float:
    beat = 0.5
    index = int(t / beat) % 16
    scales = ((0, 3, 5, 7, 10), (0, 2, 5, 7, 9), (0, 3, 5, 8, 10), (0, 2, 4, 7, 9), (0, 3, 5, 7, 9))
    scale = scales[mode % len(scales)]
    lead_note = root * (2.0 ** (scale[index % len(scale)] / 12.0))
    bass_note = root * 0.5 * (2.0 ** (scale[(index // 2) % len(scale)] / 12.0))
    pulse = 0.72 + 0.28 * math.sin(2.0 * math.pi * t / 8.0)
    return pulse * (0.12 * osc(lead_note, t, "triangle") + 0.16 * osc(bass_note, t, "square"))


def stinger(t: float, d: float, _rng: random.Random, root: float, descending: bool) -> float:
    ratio = 1.0 - t / d if descending else t / d
    frequency = root * (1.0 + 1.5 * ratio)
    return 0.36 * osc(frequency, t, "triangle") * envelope(t, d, 0.002, 0.16)


def main() -> None:
    definitions = {
        "cutter_swing.wav": (0.18, cutter, 101),
        "player_hurt.wav": (0.22, hurt, 102),
        "enemy_hit.wav": (0.12, enemy_hit, 103),
        "pickup_sample.wav": (0.34, pickup, 104),
        "dash.wav": (0.20, dash, 105),
        "boss_defeat.wav": (1.20, boss_defeat, 106),
        "radio_beep.wav": (0.16, radio_beep, 107),
    }
    for name, (duration, fn, seed) in definitions.items():
        write_wav(name, render(duration, fn, seed))
    music_definitions = {
        "menu_base_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 220.0, 0), 201),
        "level_01_grassland_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 196.0, 1), 202),
        "level_02_forest_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 174.61, 2), 203),
        "level_03_capsule_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 164.81, 3), 204),
        "level_04_marsh_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 146.83, 4), 205),
        "level_05_nexus_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 130.81, 0), 206),
        "boss_organic_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 110.0, 2), 207),
        "boss_nexus_loop.wav": (8.0, lambda t, d, r: music_loop(t, d, r, 98.0, 3), 208),
        "victory_stinger.wav": (1.0, lambda t, d, r: stinger(t, d, r, 392.0, False), 209),
        "defeat_stinger.wav": (1.0, lambda t, d, r: stinger(t, d, r, 220.0, True), 210),
    }
    for name, (duration, fn, seed) in music_definitions.items():
        write_wav(name, render(duration, fn, seed))
    print(f"Generated {len(definitions)} SFX and {len(music_definitions)} music/stinger assets in {os.fspath(OUT_DIR)}")


if __name__ == "__main__":
    main()
