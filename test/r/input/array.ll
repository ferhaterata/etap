; ModuleID = './.llvm/input.ll'
source_filename = "./input/array.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.vals = private unnamed_addr constant [4 x i32] [i32 2, i32 4, i32 8, i32 16], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %vals = alloca [4 x i32], align 16
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [4 x i32]* %vals to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([4 x i32]* @__const.main.vals to i8*), i64 16, i1 false)
  store i32 0, i32* %x, align 4
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 2
  store i32 3, i32* %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 0
  %1 = load i32, i32* %arrayidx1, align 16
  %2 = load i32, i32* %x, align 4
  %add = add nsw i32 %2, %1
  store i32 %add, i32* %x, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 1
  %3 = load i32, i32* %arrayidx2, align 4
  %4 = load i32, i32* %x, align 4
  %add3 = add nsw i32 %4, %3
  store i32 %add3, i32* %x, align 4
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %vals, i64 0, i64 2
  %5 = load i32, i32* %arrayidx4, align 8
  %6 = load i32, i32* %x, align 4
  %add5 = add nsw i32 %6, %5
  store i32 %add5, i32* %x, align 4
  %7 = load i32, i32* %x, align 4
  ret i32 %7
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
