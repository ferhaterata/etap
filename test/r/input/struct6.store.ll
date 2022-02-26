; ModuleID = 'test/r/input/struct6.ll'
source_filename = "./input/struct6.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [2 x i32] }

@__const.main.buf = private unnamed_addr constant %struct.S { [2 x i32] [i32 0, i32 1] }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %buf = alloca %struct.S, align 4, !store !4
  %p = alloca %struct.S*, align 8, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  %0 = bitcast %struct.S* %buf to i8*, !store !7
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 bitcast (%struct.S* @__const.main.buf to i8*), i64 8, i1 false), !store !8
  store %struct.S* %buf, %struct.S** %p, align 8, !store !9
  %1 = load %struct.S*, %struct.S** %p, align 8, !store !10
  %data = getelementptr inbounds %struct.S, %struct.S* %1, i32 0, i32 0, !store !11
  %arraydecay = getelementptr inbounds [2 x i32], [2 x i32]* %data, i64 0, i64 0, !store !12
  %add.ptr = getelementptr inbounds i32, i32* %arraydecay, i64 1, !store !13
  %2 = load i32, i32* %add.ptr, align 4, !store !14
  ret i32 %2, !store !15
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
!4 = !{!"sym$\\\22buf\\\22 <- alloca(\\\22%struct.S\\\22)"}
!5 = !{!"sym$\\\22p\\\22 <- alloca(\\\22%struct.S*\\\22)"}
!6 = !{!"store(0, sym$\\\22retval\\\22)"}
!7 = !{!"sym$\\\220\\\22 <- bitcast(\\\22%struct.S*\\\22, sym$\\\22buf\\\22, \\\22i8*\\\22)"}
!8 = !{!"memcpy(sym$\\\220\\\22, sym$\\\22__const.main.buf\\\22, \\\22%struct.S*\\\22)"}
!9 = !{!"store(sym$\\\22buf\\\22, sym$\\\22p\\\22)"}
!10 = !{!"sym$\\\221\\\22 <- load(sym$\\\22p\\\22)"}
!11 = !{!"sym$\\\22data\\\22 <- gep(\\\22%struct.S\\\22, sym$\\\221\\\22, 0, 0)"}
!12 = !{!"sym$\\\22arraydecay\\\22 <- gep(\\\22[2 x i32]\\\22, sym$\\\22data\\\22, 0, 0)"}
!13 = !{!"sym$\\\22add.ptr\\\22 <- gep(\\\22i32\\\22, sym$\\\22arraydecay\\\22, 1)"}
!14 = !{!"sym$\\\222\\\22 <- load(sym$\\\22add.ptr\\\22)"}
!15 = !{!"path.return <<- c(path.return, ret(sym$\\\222\\\22)); entry <- TRUE"}
