; ModuleID = 'test/r/input/local2.ll'
source_filename = "./input/local2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.index_i.nums = private unnamed_addr constant [3 x i64] [i64 1, i64 2, i64 3], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @index_i() #0 !store !2 {
entry:
  %nums = alloca [3 x i64], align 16, !store !3
  %i = alloca i64, align 8, !store !4
  %0 = bitcast [3 x i64]* %nums to i8*, !store !5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([3 x i64]* @__const.index_i.nums to i8*), i64 24, i1 false), !store !6
  store i64 2, i64* %i, align 8, !store !7
  %1 = load i64, i64* %i, align 8, !store !8
  %arrayidx = getelementptr inbounds [3 x i64], [3 x i64]* %nums, i64 0, i64 %1, !store !9
  %2 = load i64, i64* %arrayidx, align 8, !store !10
  ret i64 %2, !store !11
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22nums\\\22 <- alloca(\\\22[3 x i64]\\\22)"}
!4 = !{!"sym$\\\22i\\\22 <- alloca(\\\22i64\\\22)"}
!5 = !{!"sym$\\\220\\\22 <- bitcast(\\\22[3 x i64]*\\\22, sym$\\\22nums\\\22, \\\22i8*\\\22)"}
!6 = !{!"memcpy(sym$\\\220\\\22, sym$\\\22__const.index_i.nums\\\22, \\\22[3 x i64]*\\\22)"}
!7 = !{!"store(2, sym$\\\22i\\\22)"}
!8 = !{!"sym$\\\221\\\22 <- load(sym$\\\22i\\\22)"}
!9 = !{!"sym$\\\22arrayidx\\\22 <- gep(\\\22[3 x i64]\\\22, sym$\\\22nums\\\22, 0, sym$\\\221\\\22)"}
!10 = !{!"sym$\\\222\\\22 <- load(sym$\\\22arrayidx\\\22)"}
!11 = !{!"path.return <<- c(path.return, ret(sym$\\\222\\\22)); entry <- TRUE"}
