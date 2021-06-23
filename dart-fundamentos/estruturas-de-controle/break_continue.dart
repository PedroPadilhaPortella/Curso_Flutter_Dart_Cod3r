main() {
  for (var i = 0; i < 100; i++) {
    if (i == 5 || i == 7) continue;
    if (i == 9) break;
    print(i);
  }
}
