; ModuleID = './.llvm/input.ll'
source_filename = "./input/sort.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 0, i32 23, i32 14, i32 12, i32 9], align 16
@.str.2 = private unnamed_addr constant [18 x i8] c"Original array: \0A\00", align 1
@.str.3 = private unnamed_addr constant [36 x i8] c"\0ASorted array in Ascending order: \0A\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @swap(i32* %xp, i32* %yp) #0 {
entry:
  %0 = load i32, i32* %xp, align 4
  %1 = load i32, i32* %yp, align 4
  store i32 %1, i32* %xp, align 4
  store i32 %0, i32* %yp, align 4
  ret void
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @selectionSort(i32* %arr, i32 %n) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc11, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc12, %for.inc11 ]
  %sub = sub nsw i32 %n, 1
  %cmp = icmp slt i32 %i.0, %sub
  br i1 %cmp, label %for.body, label %for.end13

for.body:                                         ; preds = %for.cond
  %add = add nsw i32 %i.0, 1
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %min_idx.0 = phi i32 [ %i.0, %for.body ], [ %min_idx.1, %for.inc ]
  %j.0 = phi i32 [ %add, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp slt i32 %j.0, %n
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %idxprom = sext i32 %j.0 to i64
  %arrayidx = getelementptr inbounds i32, i32* %arr, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4
  %idxprom4 = sext i32 %min_idx.0 to i64
  %arrayidx5 = getelementptr inbounds i32, i32* %arr, i64 %idxprom4
  %1 = load i32, i32* %arrayidx5, align 4
  %cmp6 = icmp slt i32 %0, %1
  br i1 %cmp6, label %if.then, label %if.end

if.then:                                          ; preds = %for.body3
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body3
  %min_idx.1 = phi i32 [ %j.0, %if.then ], [ %min_idx.0, %for.body3 ]
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %j.0, 1
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  %idxprom7 = sext i32 %min_idx.0 to i64
  %arrayidx8 = getelementptr inbounds i32, i32* %arr, i64 %idxprom7
  %idxprom9 = sext i32 %i.0 to i64
  %arrayidx10 = getelementptr inbounds i32, i32* %arr, i64 %idxprom9
  %2 = load i32, i32* %arrayidx8, align 4
  %3 = load i32, i32* %arrayidx10, align 4
  store i32 %3, i32* %arrayidx8, align 4
  store i32 %2, i32* %arrayidx10, align 4
  br label %for.inc11

for.inc11:                                        ; preds = %for.end
  %inc12 = add nsw i32 %i.0, 1
  br label %for.cond

for.end13:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @insertionSort(i32* %arr, i32 %n) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, i32* %arr, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4
  %sub = sub nsw i32 %i.0, 1
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.body
  %j.0 = phi i32 [ %sub, %for.body ], [ %sub9, %while.body ]
  %cmp1 = icmp sge i32 %j.0, 0
  br i1 %cmp1, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %idxprom2 = sext i32 %j.0 to i64
  %arrayidx3 = getelementptr inbounds i32, i32* %arr, i64 %idxprom2
  %1 = load i32, i32* %arrayidx3, align 4
  %cmp4 = icmp sgt i32 %1, %0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %2 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ]
  br i1 %2, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %idxprom5 = sext i32 %j.0 to i64
  %arrayidx6 = getelementptr inbounds i32, i32* %arr, i64 %idxprom5
  %3 = load i32, i32* %arrayidx6, align 4
  %add = add nsw i32 %j.0, 1
  %idxprom7 = sext i32 %add to i64
  %arrayidx8 = getelementptr inbounds i32, i32* %arr, i64 %idxprom7
  store i32 %3, i32* %arrayidx8, align 4
  %sub9 = sub nsw i32 %j.0, 1
  br label %while.cond

while.end:                                        ; preds = %land.end
  %add10 = add nsw i32 %j.0, 1
  %idxprom11 = sext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds i32, i32* %arr, i64 %idxprom11
  store i32 %0, i32* %arrayidx12, align 4
  br label %for.inc

for.inc:                                          ; preds = %while.end
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @printArray(i32* %arr, i32 %size) #1 {
entry:
  %arr.addr = alloca i32*, align 8
  %size.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  store i32 %size, i32* %size.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %size.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32*, i32** %arr.addr, align 8
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom
  %4 = load i32, i32* %arrayidx, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %4)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  ret void
}

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #1 {
entry:
  %arr.addr.i = alloca i32*, align 8
  %n.addr.i = alloca i32, align 4
  %key.i = alloca i32, align 4
  %j.i = alloca i32, align 4
  %i.i = alloca i32, align 4
  %retval = alloca i32, align 4
  %arr = alloca [5 x i32], align 16
  %n = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [5 x i32]* %arr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([5 x i32]* @__const.main.arr to i8*), i64 20, i1 false)
  store i32 5, i32* %n, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.2, i64 0, i64 0))
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0
  %1 = load i32, i32* %n, align 4
  call void @printArray(i32* %arraydecay, i32 %1)
  %arraydecay1 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0
  %2 = load i32, i32* %n, align 4
  store i32* %arraydecay1, i32** %arr.addr.i, align 8
  store i32 %2, i32* %n.addr.i, align 4
  store i32 1, i32* %i.i, align 4
  br label %for.cond.i

for.cond.i:                                       ; preds = %while.end.i, %entry
  %3 = load i32, i32* %i.i, align 4
  %4 = load i32, i32* %n.addr.i, align 4
  %cmp.i = icmp slt i32 %3, %4
  br i1 %cmp.i, label %for.body.i, label %insertionSort.exit

for.body.i:                                       ; preds = %for.cond.i
  %5 = load i32*, i32** %arr.addr.i, align 8
  %6 = load i32, i32* %i.i, align 4
  %idxprom.i = sext i32 %6 to i64
  %arrayidx.i = getelementptr inbounds i32, i32* %5, i64 %idxprom.i
  %7 = load i32, i32* %arrayidx.i, align 4
  store i32 %7, i32* %key.i, align 4
  %8 = load i32, i32* %i.i, align 4
  %sub.i = sub nsw i32 %8, 1
  store i32 %sub.i, i32* %j.i, align 4
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %for.body.i
  %9 = load i32, i32* %j.i, align 4
  %cmp1.i = icmp sge i32 %9, 0
  br i1 %cmp1.i, label %land.rhs.i, label %land.end.i

land.rhs.i:                                       ; preds = %while.cond.i
  %10 = load i32*, i32** %arr.addr.i, align 8
  %11 = load i32, i32* %j.i, align 4
  %idxprom2.i = sext i32 %11 to i64
  %arrayidx3.i = getelementptr inbounds i32, i32* %10, i64 %idxprom2.i
  %12 = load i32, i32* %arrayidx3.i, align 4
  %13 = load i32, i32* %key.i, align 4
  %cmp4.i = icmp sgt i32 %12, %13
  br label %land.end.i

land.end.i:                                       ; preds = %land.rhs.i, %while.cond.i
  %14 = phi i1 [ false, %while.cond.i ], [ %cmp4.i, %land.rhs.i ]
  br i1 %14, label %while.body.i, label %while.end.i

while.body.i:                                     ; preds = %land.end.i
  %15 = load i32*, i32** %arr.addr.i, align 8
  %16 = load i32, i32* %j.i, align 4
  %idxprom5.i = sext i32 %16 to i64
  %arrayidx6.i = getelementptr inbounds i32, i32* %15, i64 %idxprom5.i
  %17 = load i32, i32* %arrayidx6.i, align 4
  %18 = load i32*, i32** %arr.addr.i, align 8
  %19 = load i32, i32* %j.i, align 4
  %add.i = add nsw i32 %19, 1
  %idxprom7.i = sext i32 %add.i to i64
  %arrayidx8.i = getelementptr inbounds i32, i32* %18, i64 %idxprom7.i
  store i32 %17, i32* %arrayidx8.i, align 4
  %20 = load i32, i32* %j.i, align 4
  %sub9.i = sub nsw i32 %20, 1
  store i32 %sub9.i, i32* %j.i, align 4
  br label %while.cond.i

while.end.i:                                      ; preds = %land.end.i
  %21 = load i32, i32* %key.i, align 4
  %22 = load i32*, i32** %arr.addr.i, align 8
  %23 = load i32, i32* %j.i, align 4
  %add10.i = add nsw i32 %23, 1
  %idxprom11.i = sext i32 %add10.i to i64
  %arrayidx12.i = getelementptr inbounds i32, i32* %22, i64 %idxprom11.i
  store i32 %21, i32* %arrayidx12.i, align 4
  %24 = load i32, i32* %i.i, align 4
  %inc.i = add nsw i32 %24, 1
  store i32 %inc.i, i32* %i.i, align 4
  br label %for.cond.i

insertionSort.exit:                               ; preds = %for.cond.i
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.3, i64 0, i64 0))
  %arraydecay3 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0
  %25 = load i32, i32* %n, align 4
  call void @printArray(i32* %arraydecay3, i32 %25)
  %26 = load i32, i32* %n, align 4
  %sub = sub nsw i32 %26, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 %idxprom
  %27 = load i32, i32* %arrayidx, align 4
  ret i32 %27
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
