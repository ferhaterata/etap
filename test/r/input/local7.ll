; ModuleID = './.llvm/input.ll'
source_filename = "./input/local7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.arr = private unnamed_addr constant [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 9, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca [2 x [3 x [4 x i32]]], align 16
  %i = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [2 x [3 x [4 x i32]]]* %arr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([2 x [3 x [4 x i32]]]* @__const.main.arr to i8*), i64 96, i1 false)
  store i32 0, i32* %i, align 4
  store i32 1, i32* %k, align 4
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr, i64 0, i64 %idxprom
  %2 = load i32, i32* %i, align 4
  %add = add nsw i32 %2, 1
  %idxprom1 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom1
  %3 = load i32, i32* %k, align 4
  %idxprom3 = sext i32 %3 to i64
  %arrayidx4 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx2, i64 0, i64 %idxprom3
  %4 = load i32, i32* %arrayidx4, align 4
  ret i32 %4
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
