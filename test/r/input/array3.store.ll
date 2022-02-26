; ModuleID = 'test/r/input/array3.ll'
source_filename = "./input/array3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nums = dso_local global [3 x [3 x i64]] [[3 x i64] [i64 1, i64 2, i64 3], [3 x i64] [i64 2, i64 3, i64 4], [3 x i64] [i64 3, i64 4, i64 5]], align 16, !global !0
@i = dso_local global i64 2, align 8, !global !1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @index_i2() #0 !store !4 {
entry:
  %0 = load i64, i64* @i, align 8, !store !5
  %arrayidx = getelementptr inbounds [3 x [3 x i64]], [3 x [3 x i64]]* @nums, i64 0, i64 %0, !store !6
  %1 = load i64, i64* @i, align 8, !store !7
  %arrayidx1 = getelementptr inbounds [3 x i64], [3 x i64]* %arrayidx, i64 0, i64 %1, !store !8
  %2 = load i64, i64* %arrayidx1, align 8, !store !9
  ret i64 %2, !store !10
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{!"c.nums <- env(\\\220\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3), \\\221\\\22 = list(\\\220\\\22 = 2, \\\221\\\22 = 3, \\\222\\\22 = 4), \\\222\\\22 = list(\\\220\\\22 = 3, \\\221\\\22 = 4, \\\222\\\22 = 5))"}
!1 = !{!"c.i <- 2"}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!4 = !{!"entry <- F"}
!5 = !{!"v.0 <- load(ptr(c.i))"}
!6 = !{!"p.arrayidx <- gep(ptr(c.nums), 0, v.0)"}
!7 = !{!"v.1 <- load(ptr(c.i))"}
!8 = !{!"p.arrayidx1 <- gep(p.arrayidx, 0, v.1)"}
!9 = !{!"v.2 <- load(p.arrayidx1)"}
!10 = !{!".ret <- ret(v.2); entry <- T"}
