; ModuleID = 'test/r/input/array4.ll'
source_filename = "./input/array4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nums = dso_local global [3 x [3 x i64]] [[3 x i64] [i64 1, i64 2, i64 3], [3 x i64] [i64 2, i64 3, i64 4], [3 x i64] [i64 3, i64 4, i64 5]], align 16
@i = dso_local global i64 1, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @index_i2() #0 !store !2 {
entry:
  %0 = load i64, i64* @i, align 8, !store !3
  %arrayidx = getelementptr inbounds [3 x [3 x i64]], [3 x [3 x i64]]* @nums, i64 0, i64 %0, !store !4
  %1 = load i64, i64* @i, align 8, !store !5
  %add = add nsw i64 %1, 1, !store !6
  %arrayidx1 = getelementptr inbounds [3 x i64], [3 x i64]* %arrayidx, i64 0, i64 %add, !store !7
  %2 = load i64, i64* %arrayidx1, align 8, !store !8
  ret i64 %2, !store !9
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22%0\\\22 <- load(ptr(sym$\\\22@i\\\22))"}
!4 = !{!"sym$\\\22%arrayidx\\\22 <- gep(\\\22[3 x [3 x i64]]\\\22, sym$\\\22@nums\\\22, 0, sym$\\\22%0\\\22)"}
!5 = !{!"sym$\\\22%1\\\22 <- load(ptr(sym$\\\22@i\\\22))"}
!6 = !{!"sym$\\\22%add\\\22 <- add(sym$\\\22%1\\\22, 1)"}
!7 = !{!"sym$\\\22%arrayidx1\\\22 <- gep(\\\22[3 x i64]\\\22, sym$\\\22%arrayidx\\\22, 0, sym$\\\22%add\\\22)"}
!8 = !{!"sym$\\\22%2\\\22 <- load(sym$\\\22%arrayidx1\\\22)"}
!9 = !{!"path.return <<- c(path.return, ret(sym$\\\22%2\\\22)); entry <- TRUE"}
