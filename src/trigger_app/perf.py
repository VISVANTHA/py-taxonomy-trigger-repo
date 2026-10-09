"""Performance static patterns: N+1, nested loops, alloc-in-loop, threads."""

import threading

import requests


def fetch_each(urls: list[str]) -> list[int]:
    sizes = []
    for url in urls:
        response = requests.get(url, timeout=1)
        sizes.append(response.status_code)
    return sizes


def triple_loop(a: list[int], b: list[int], c: list[int]) -> int:
    total = 0
    for i in a:
        for j in b:
            for k in c:
                total += i + j + k
    return total


def nested_append(rows: list[list[int]]) -> list[int]:
    out: list[int] = []
    for row in rows:
        for item in row:
            out.append(item)
    return out


def start_workers(n: int) -> None:
    for _ in range(n):
        worker = threading.Thread(target=lambda: None)
        worker.start()
