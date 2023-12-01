const std = @import("std");
const data = @embedFile("./input.txt");

const map = std.meta.Tuple(&.{[]const u8, u8});
const number_mapping = [_]map{
   .{"one"  , 1},
   .{"two"  , 2},
   .{"three", 3},
   .{"four" , 4},
   .{"five" , 5},
   .{"six"  , 6},
   .{"seven", 7},
   .{"eight", 8},
   .{"nine" , 9}
};

pub fn main() !void {
   var lines = std.mem.tokenizeScalar(u8, data, '\n');
   var total: u64 = 0;
   while (lines.next()) |line| {
      var fst_found: bool = false;
      var fst_digit: u8 = undefined;
      var lst_digit: u8 = undefined;
      for (0..line.len) |i| {
         var rest = line[i..];
         var found_val = false;
         var val: u8 = undefined;
         if (std.ascii.isDigit(rest[0])) {
            found_val = true;
            val = rest[0] - '0';
         } else {
            for (number_mapping) |m| {
               if (std.ascii.startsWithIgnoreCase(rest, m[0])) {
                  found_val = true;
                  val = m[1];
                  break;
               }
            }
         }
         if (found_val) {
            lst_digit = val;
            if (!fst_found) {
               fst_digit = val;
               fst_found = true;
            }
         }
      }
      total += fst_digit * 10 + lst_digit;
   }
   std.debug.print("{}\n", .{total});
}
