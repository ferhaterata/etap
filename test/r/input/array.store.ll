; ModuleID = 'test/r/input/array.ll'
source_filename = "./input/array.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.vals = private unnamed_addr constant [4 x i32] [i32 2, i32 4, i32 8, i32 16], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %vals = alloca [4 x i32], align 16, !store !4
  %x = alloca i32, align 4, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  %0 = bitcast [4 x i32]* %vals to i8*, !store !7
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([4 x i32]* @__const.main.vals to i8*), i64 16, i1 false), !store !8
  store i32 0, i32* %x, align 4, !store !9
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 2, !store !10
  store i32 3, i32* %arrayidx, align 8, !store !11
  %arrayidx1 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 0, !store !12
  %1 = load i32, i32* %arrayidx1, align 16, !store !13
  %2 = load i32, i32* %x, align 4, !store !14
  %add = add nsw i32 %2, %1, !store !15
  store i32 %add, i32* %x, align 4, !store !16
  %arrayidx2 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 1, !store !17
  %3 = load i32, i32* %arrayidx2, align 4, !store !18
  %4 = load i32, i32* %x, align 4, !store !19
  %add3 = add nsw i32 %4, %3, !store !20
  store i32 %add3, i32* %x, align 4, !store !21
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 2, !store !22
  %5 = load i32, i32* %arrayidx4, align 8, !store !23
  %6 = load i32, i32* %x, align 4, !store !24
  %add5 = add nsw i32 %6, %5, !store !25
  store i32 %add5, i32* %x, align 4, !store !26
  %7 = load i32, i32* %x, align 4, !store !27
  ret i32 %7, !store !28
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
!3 = !{!"sym$\\\22%retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22%vals\\\22 <- alloca(\\\22[4 x i32]\\\22)"}
!5 = !{!"sym$\\\22%x\\\22 <- alloca(\\\22i32\\\22)"}
!6 = !{!"store(0, sym$\\\22%retval\\\22)"}
!7 = !{!"sym$\\\22%0\\\22 <- bitcast(\\\22[4 x i32]*\\\22, sym$\\\22%vals\\\22, \\\22i8*\\\22)"}
!8 = !{!"memcpy(sym$\\\22%0\\\22, ptr(sym$\\\22@__const.main.vals\\\22))"}
!9 = !{!"store(0, sym$\\\22%x\\\22)"}
!10 = !{!"sym$\\\22%arrayidx\\\22 <- gep(\\\22[4 x i32]\\\22, sym$\\\22%vals\\\22, 0, 2)"}
!11 = !{!"store(3, sym$\\\22%arrayidx\\\22)"}
!12 = !{!"sym$\\\22%arrayidx1\\\22 <- gep(\\\22[4 x i32]\\\22, sym$\\\22%vals\\\22, 0, 0)"}
!13 = !{!"sym$\\\22%1\\\22 <- load(sym$\\\22%arrayidx1\\\22)"}
!14 = !{!"sym$\\\22%2\\\22 <- load(sym$\\\22%x\\\22)"}
!15 = !{!"sym$\\\22%add\\\22 <- add(sym$\\\22%2\\\22, sym$\\\22%1\\\22)"}
!16 = !{!"store(sym$\\\22%add\\\22, sym$\\\22%x\\\22)"}
!17 = !{!"sym$\\\22%arrayidx2\\\22 <- gep(\\\22[4 x i32]\\\22, sym$\\\22%vals\\\22, 0, 1)"}
!18 = !{!"sym$\\\22%3\\\22 <- load(sym$\\\22%arrayidx2\\\22)"}
!19 = !{!"sym$\\\22%4\\\22 <- load(sym$\\\22%x\\\22)"}
!20 = !{!"sym$\\\22%add3\\\22 <- add(sym$\\\22%4\\\22, sym$\\\22%3\\\22)"}
!21 = !{!"store(sym$\\\22%add3\\\22, sym$\\\22%x\\\22)"}
!22 = !{!"sym$\\\22%arrayidx4\\\22 <- gep(\\\22[4 x i32]\\\22, sym$\\\22%vals\\\22, 0, 2)"}
!23 = !{!"sym$\\\22%5\\\22 <- load(sym$\\\22%arrayidx4\\\22)"}
!24 = !{!"sym$\\\22%6\\\22 <- load(sym$\\\22%x\\\22)"}
!25 = !{!"sym$\\\22%add5\\\22 <- add(sym$\\\22%6\\\22, sym$\\\22%5\\\22)"}
!26 = !{!"store(sym$\\\22%add5\\\22, sym$\\\22%x\\\22)"}
!27 = !{!"sym$\\\22%7\\\22 <- load(sym$\\\22%x\\\22)"}
!28 = !{!"path.return <<- c(path.return, ret(sym$\\\22%7\\\22)); entry <- TRUE"}
