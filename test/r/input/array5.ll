; ModuleID = './input/array5.c'
source_filename = "./input/array5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@arr = dso_local global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16
@i = dso_local global i32 0, align 4
@k = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @index_i2k() #0 {
entry:
  %0 = load i32, i32* @i, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* @arr, i64 0, i64 %idxprom
  %1 = load i32, i32* @i, align 4
  %add = add nsw i32 %1, 1
  %idxprom1 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom1
  %2 = load i32, i32* @k, align 4
  %idxprom3 = sext i32 %2 to i64
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx2, i64 0, i64 %idxprom3
  %3 = load i32, i32* %arrayidx4, align 4
  %conv = sext i32 %3 to i64
  ret i64 %conv
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}