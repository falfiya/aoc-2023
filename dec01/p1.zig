const std = @import("std");
const data = @embedFile("./input.txt");

pub fn main() !void {
   var lines = std.mem.tokenizeScalar(u8, data, '\n');
   var total: u64 = 0;
   while (lines.next()) |line| {
      var fst_found: bool = false;
      var fst_digit: u8 = undefined;
      var lst_digit: u8 = undefined;
      for (line) |c| {
         if (std.ascii.isDigit(c)) {
            var val = c - '0';
            lst_digit = val;
            if (!fst_found) {
               fst_digit = c - '0';
               fst_found = true;
            }
         }
      }
      total += fst_digit * 10 + lst_digit;
   }
   std.debug.print("{}\n", .{total});
}
