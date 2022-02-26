; ModuleID = 'test/r/input/array5.ll'
source_filename = "./input/array5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@arr = dso_local global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16, !global !0
@i = dso_local global i32 0, align 4, !global !1
@k = dso_local global i32 0, align 4, !global !2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @index_i2k() #0 !store !5 {
entry:
  %0 = load i32, i32* @i, align 4, !store !6
  %idxprom = sext i32 %0 to i64, !store !7
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* @arr, i64 0, i64 %idxprom, !store !8
  %1 = load i32, i32* @i, align 4, !store !9
  %add = add nsw i32 %1, 1, !store !10
  %idxprom1 = sext i32 %add to i64, !store !11
  %arrayidx2 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom1, !store !12
  %2 = load i32, i32* @k, align 4, !store !13
  %idxprom3 = sext i32 %2 to i64, !store !14
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx2, i64 0, i64 %idxprom3, !store !15
  %3 = load i32, i32* %arrayidx4, align 4, !store !16
  %conv = sext i32 %3 to i64, !store !17
  ret i64 %conv, !store !18
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!3}
!llvm.ident = !{!4}

!0 = !{!"c.arr <- env(\\\220\\\22 = list(\\\220\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4), \\\221\\\22 = list(\\\220\\\22 = 5, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4), \\\222\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4)), \\\221\\\22 = list(\\\220\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4), \\\221\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4), \\\222\\\22 = list(\\\220\\\22 = 1, \\\221\\\22 = 2, \\\222\\\22 = 3, \\\223\\\22 = 4)))"}
!1 = !{!"c.i <- 0"}
!2 = !{!"c.k <- 0"}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!5 = !{!"entry <- F"}
!6 = !{!"v.0 <- load(ptr(c.i))"}
!7 = !{!"v.idxprom <- sext(v.0)"}
!8 = !{!"p.arrayidx <- gep(ptr(c.arr), 0, v.idxprom)"}
!9 = !{!"v.1 <- load(ptr(c.i))"}
!10 = !{!"v.add <- add(v.1, 1)"}
!11 = !{!"v.idxprom1 <- sext(v.add)"}
!12 = !{!"p.arrayidx2 <- gep(p.arrayidx, 0, v.idxprom1)"}
!13 = !{!"v.2 <- load(ptr(c.k))"}
!14 = !{!"v.idxprom3 <- sext(v.2)"}
!15 = !{!"p.arrayidx4 <- gep(p.arrayidx2, 0, v.idxprom3)"}
!16 = !{!"v.3 <- load(p.arrayidx4)"}
!17 = !{!"v.conv <- sext(v.3)"}
!18 = !{!".ret <- ret(v.conv); entry <- T"}
