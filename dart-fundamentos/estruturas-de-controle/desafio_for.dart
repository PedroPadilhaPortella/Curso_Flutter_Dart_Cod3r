// main() {
//   String cerquilha = '#';
//   for (var i = 0; i < 6; i++) {
//     print('$cerquilha');
//     cerquilha += "#";
//   }
// }

main() {
  for (String cerquilha = '#'; cerquilha.length < 6; cerquilha += '#') {
    print('$cerquilha');
  }
}
