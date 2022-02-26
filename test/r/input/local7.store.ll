; ModuleID = 'test/r/input/local7.ll'
source_filename = "./input/local7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.arr = private unnamed_addr constant [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %arr = alloca [2 x [3 x [4 x i32]]], align 16, !store !4
  %i = alloca i32, align 4, !store !5
  %k = alloca i32, align 4, !store !6
  store i32 0, i32* %retval, align 4, !store !7
  %0 = bitcast [2 x [3 x [4 x i32]]]* %arr to i8*, !store !8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([2 x [3 x [4 x i32]]]* @__const.main.arr to i8*), i64 96, i1 false), !store !9
  store i32 0, i32* %i, align 4, !store !10
  store i32 1, i32* %k, align 4, !store !11
  %1 = load i32, i32* %i, align 4, !store !12
  %idxprom = sext i32 %1 to i64, !store !13
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr, i64 0, i64 %idxprom, !store !14
  %2 = load i32, i32* %i, align 4, !store !15
  %add = add nsw i32 %2, 1, !store !16
  %idxprom1 = sext i32 %add to i64, !store !17
  %arrayidx2 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom1, !store !18
  %3 = load i32, i32* %k, align 4, !store !19
  %idxprom3 = sext i32 %3 to i64, !store !20
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx2, i64 0, i64 %idxprom3, !store !21
  %4 = load i32, i32* %arrayidx4, align 4, !store !22
  ret i32 %4, !store !23
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
!3 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22arr\\\22 <- alloca(\\\22[2 x [3 x [4 x i32]]]\\\22)"}
!5 = !{!"sym$\\\22i\\\22 <- alloca(\\\22i32\\\22)"}
!6 = !{!"sym$\\\22k\\\22 <- alloca(\\\22i32\\\22)"}
!7 = !{!"store(0, sym$\\\22retval\\\22)"}
!8 = !{!"sym$\\\220\\\22 <- bitcast(\\\22[2 x [3 x [4 x i32]]]*\\\22, sym$\\\22arr\\\22, \\\22i8*\\\22)"}
!9 = !{!"memcpy(sym$\\\220\\\22, sym$\\\22__const.main.arr\\\22, \\\22[2 x [3 x [4 x i32]]]\\\22)"}
!10 = !{!"store(0, sym$\\\22i\\\22)"}
!11 = !{!"store(1, sym$\\\22k\\\22)"}
!12 = !{!"sym$\\\221\\\22 <- load(sym$\\\22i\\\22)"}
!13 = !{!"sym$\\\22idxprom\\\22 <- sext(\\\22i32\\\22, sym$\\\221\\\22, \\\22i64\\\22)"}
!14 = !{!"sym$\\\22arrayidx\\\22 <- gep(\\\22[2 x [3 x [4 x i32]]]\\\22, sym$\\\22arr\\\22, 0, sym$\\\22idxprom\\\22)"}
!15 = !{!"sym$\\\222\\\22 <- load(sym$\\\22i\\\22)"}
!16 = !{!"sym$\\\22add\\\22 <- add(sym$\\\222\\\22, 1)"}
!17 = !{!"sym$\\\22idxprom1\\\22 <- sext(\\\22i32\\\22, sym$\\\22add\\\22, \\\22i64\\\22)"}
!18 = !{!"sym$\\\22arrayidx2\\\22 <- gep(\\\22[3 x [4 x i32]]\\\22, sym$\\\22arrayidx\\\22, 0, sym$\\\22idxprom1\\\22)"}
!19 = !{!"sym$\\\223\\\22 <- load(sym$\\\22k\\\22)"}
!20 = !{!"sym$\\\22idxprom3\\\22 <- sext(\\\22i32\\\22, sym$\\\223\\\22, \\\22i64\\\22)"}
!21 = !{!"sym$\\\22arrayidx4\\\22 <- gep(\\\22[4 x i32]\\\22, sym$\\\22arrayidx2\\\22, 0, sym$\\\22idxprom3\\\22)"}
!22 = !{!"sym$\\\224\\\22 <- load(sym$\\\22arrayidx4\\\22)"}
!23 = !{!"path.return <<- c(path.return, ret(sym$\\\224\\\22)); entry <- TRUE"}
