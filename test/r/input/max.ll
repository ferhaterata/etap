; ModuleID = './.llvm/input.ll'
source_filename = "./input/max.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 10, i32 324, i32 45, i32 90, i32 9808], align 16
@.str = private unnamed_addr constant [29 x i8] c"Largest in given array is %d\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @largest(i32* %arr, i32 %n) #0 !distribution !2 !distribution !3 {
entry:
  %arrayidx = getelementptr inbounds i32, i32* %arr, i64 0
  %0 = load i32, i32* %arrayidx, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %max.0 = phi i32 [ %0, %entry ], [ %max.1, %for.inc ]
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64
  %arrayidx1 = getelementptr inbounds i32, i32* %arr, i64 %idxprom
  %1 = load i32, i32* %arrayidx1, align 4
  %cmp2 = icmp sgt i32 %1, %max.0
  br i1 %cmp2, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %idxprom3 = sext i32 %i.0 to i64
  %arrayidx4 = getelementptr inbounds i32, i32* %arr, i64 %idxprom3
  %2 = load i32, i32* %arrayidx4, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %max.1 = phi i32 [ %2, %if.then ], [ %max.0, %for.body ]
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 %max.0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #1 {
entry:
  %arr.addr.i = alloca i32*, align 8
  %n.addr.i = alloca i32, align 4
  %max.i = alloca i32, align 4
  %i.i = alloca i32, align 4
  %retval = alloca i32, align 4
  %arr = alloca [5 x i32], align 16
  %n = alloca i32, align 4
  %max = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [5 x i32]* %arr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([5 x i32]* @__const.main.arr to i8*), i64 20, i1 false)
  store i32 5, i32* %n, align 4
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0
  %1 = load i32, i32* %n, align 4
  store i32* %arraydecay, i32** %arr.addr.i, align 8
  store i32 %1, i32* %n.addr.i, align 4
  %2 = load i32*, i32** %arr.addr.i, align 8
  %3 = load i32, i32* %2, align 4
  store i32 %3, i32* %max.i, align 4
  store i32 1, i32* %i.i, align 4
  br label %for.cond.i

for.cond.i:                                       ; preds = %if.end.i, %entry
  %4 = load i32, i32* %i.i, align 4
  %5 = load i32, i32* %n.addr.i, align 4
  %cmp.i = icmp slt i32 %4, %5
  br i1 %cmp.i, label %for.body.i, label %largest.exit

for.body.i:                                       ; preds = %for.cond.i
  %6 = load i32*, i32** %arr.addr.i, align 8
  %7 = load i32, i32* %i.i, align 4
  %idxprom.i = sext i32 %7 to i64
  %arrayidx1.i = getelementptr inbounds i32, i32* %6, i64 %idxprom.i
  %8 = load i32, i32* %arrayidx1.i, align 4
  %9 = load i32, i32* %max.i, align 4
  %cmp2.i = icmp sgt i32 %8, %9
  br i1 %cmp2.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %for.body.i
  %10 = load i32*, i32** %arr.addr.i, align 8
  %11 = load i32, i32* %i.i, align 4
  %idxprom3.i = sext i32 %11 to i64
  %arrayidx4.i = getelementptr inbounds i32, i32* %10, i64 %idxprom3.i
  %12 = load i32, i32* %arrayidx4.i, align 4
  store i32 %12, i32* %max.i, align 4
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %for.body.i
  %13 = load i32, i32* %i.i, align 4
  %inc.i = add nsw i32 %13, 1
  store i32 %inc.i, i32* %i.i, align 4
  br label %for.cond.i

largest.exit:                                     ; preds = %for.cond.i
  %14 = load i32, i32* %max.i, align 4
  store i32 %14, i32* %max, align 4
  %15 = load i32, i32* %max, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i64 0, i64 0), i32 %15)
  %16 = load i32, i32* %max, align 4
  ret i32 %16
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local i32 @printf(i8*, ...) #3

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"}
!3 = !{!"n <- DiscreteDistribution(supp=1:4)"}
