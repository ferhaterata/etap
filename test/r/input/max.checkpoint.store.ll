; ModuleID = './.llvm/inst-conf.ll'
source_filename = "./input/max.c"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430"

@__const.main.arr = private unnamed_addr constant [5 x i16] [i16 10, i16 324, i16 45, i16 90, i16 8000], align 2
@.str = private unnamed_addr constant [29 x i8] c"Largest in given array is %d\00", align 1

; Function Attrs: noinline nounwind optnone
define dso_local void @checkpoint() #0 !timing !2 !energy !3 !intermittent !4 !intermittent !5 {
entry:
  ret void, !cost !6
}

; Function Attrs: alwaysinline nounwind
define dso_local i16 @largest(i16* %arr, i16 %n) #1 !distribution !7 !distribution !8 {
entry:
  call void @checkpoint(), !cost !6
  %arrayidx = getelementptr inbounds i16, i16* %arr, i16 0, !cost !6
  %0 = load i16, i16* %arrayidx, align 2, !cost !6
  br label %for.cond, !cost !6

for.cond:                                         ; preds = %for.inc, %entry
  %max.0 = phi i16 [ %0, %entry ], [ %max.1, %for.inc ], !cost !6
  %i.0 = phi i16 [ 1, %entry ], [ %inc, %for.inc ], !cost !6
  %cmp = icmp slt i16 %i.0, %n, !cost !6
  br i1 %cmp, label %for.body, label %for.end, !cost !6

for.body:                                         ; preds = %for.cond
  %arrayidx1 = getelementptr inbounds i16, i16* %arr, i16 %i.0, !cost !6
  %1 = load i16, i16* %arrayidx1, align 2, !cost !6
  %cmp2 = icmp sgt i16 %1, %max.0, !cost !6
  br i1 %cmp2, label %if.then, label %if.end, !cost !6

if.then:                                          ; preds = %for.body
  %arrayidx3 = getelementptr inbounds i16, i16* %arr, i16 %i.0, !cost !6
  %2 = load i16, i16* %arrayidx3, align 2, !cost !6
  br label %if.end, !cost !6

if.end:                                           ; preds = %if.then, %for.body
  %max.1 = phi i16 [ %2, %if.then ], [ %max.0, %for.body ], !cost !6
  br label %for.inc, !cost !6

for.inc:                                          ; preds = %if.end
  %inc = add nsw i16 %i.0, 1, !cost !6
  br label %for.cond, !cost !6

for.end:                                          ; preds = %for.cond
  call void @checkpoint(), !cost !6
  ret i16 %max.0, !cost !6
}

; Function Attrs: noinline nounwind optnone
define dso_local i16 @main() #0 {
entry:
  %arr.addr.i = alloca i16*, align 2, !cost !6
  %n.addr.i = alloca i16, align 2, !cost !6
  %max.i = alloca i16, align 2, !cost !6
  %i.i = alloca i16, align 2, !cost !6
  %retval = alloca i16, align 2, !cost !6
  %arr = alloca [5 x i16], align 2, !cost !6
  %n = alloca i16, align 2, !cost !6
  %max = alloca i16, align 2, !cost !6
  br label %entry4

entry4:                                           ; preds = %entry
  store i16 0, i16* %retval, align 2, !cost !6
  %0 = bitcast [5 x i16]* %arr to i8*, !cost !6
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 2 %0, i8* align 2 bitcast ([5 x i16]* @__const.main.arr to i8*), i16 10, i1 false), !cost !6
  store i16 5, i16* %n, align 2, !cost !6
  br label %entry45

entry45:                                          ; preds = %entry4
  %arraydecay = getelementptr inbounds [5 x i16], [5 x i16]* %arr, i16 0, i16 0, !cost !6
  %1 = load i16, i16* %n, align 2, !cost !6
  br label %entry456

entry456:                                         ; preds = %entry45
  store i16* %arraydecay, i16** %arr.addr.i, align 2, !cost !6
  store i16 %1, i16* %n.addr.i, align 2, !cost !6
  br label %checkpoint.1

checkpoint.1:                                     ; preds = %entry456
  call void @checkpoint() #4, !cost !6
  %2 = load i16*, i16** %arr.addr.i, align 2, !cost !6
  %3 = load i16, i16* %2, align 2, !cost !6
  br label %checkpoint.11

checkpoint.11:                                    ; preds = %checkpoint.1
  store i16 %3, i16* %max.i, align 2, !cost !6
  store i16 1, i16* %i.i, align 2, !cost !6
  br label %for.cond.i, !cost !6

for.cond.i:                                       ; preds = %if.end.i, %checkpoint.11
  %4 = load i16, i16* %i.i, align 2, !cost !6
  %5 = load i16, i16* %n.addr.i, align 2, !cost !6
  %cmp.i = icmp slt i16 %4, %5, !cost !6
  br i1 %cmp.i, label %for.body.i, label %largest.exit, !cost !6

for.body.i:                                       ; preds = %for.cond.i
  %6 = load i16*, i16** %arr.addr.i, align 2, !cost !6
  %7 = load i16, i16* %i.i, align 2, !cost !6
  %arrayidx1.i = getelementptr inbounds i16, i16* %6, i16 %7, !cost !6
  br label %for.body.i2

for.body.i2:                                      ; preds = %for.body.i
  %8 = load i16, i16* %arrayidx1.i, align 2, !cost !6
  %9 = load i16, i16* %max.i, align 2, !cost !6
  %cmp2.i = icmp sgt i16 %8, %9, !cost !6
  br i1 %cmp2.i, label %if.then.i, label %if.end.i, !cost !6

if.then.i:                                        ; preds = %for.body.i2
  %10 = load i16*, i16** %arr.addr.i, align 2, !cost !6
  %11 = load i16, i16* %i.i, align 2, !cost !6
  %arrayidx3.i = getelementptr inbounds i16, i16* %10, i16 %11, !cost !6
  br label %if.then.i7

if.then.i7:                                       ; preds = %if.then.i
  %12 = load i16, i16* %arrayidx3.i, align 2, !cost !6
  store i16 %12, i16* %max.i, align 2, !cost !6
  br label %if.end.i, !cost !6

if.end.i:                                         ; preds = %if.then.i7, %for.body.i2
  %13 = load i16, i16* %i.i, align 2, !cost !6
  %inc.i = add nsw i16 %13, 1, !cost !6
  store i16 %inc.i, i16* %i.i, align 2, !cost !6
  br label %for.cond.i, !cost !6

largest.exit:                                     ; preds = %for.cond.i
  call void @checkpoint() #4, !cost !6
  %14 = load i16, i16* %max.i, align 2, !cost !6
  store i16 %14, i16* %max, align 2, !cost !6
  br label %largest.exit3

largest.exit3:                                    ; preds = %largest.exit
  %15 = load i16, i16* %max, align 2, !cost !6
  %call1 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i16 0, i16 0), i16 %15), !cost !6
  %16 = load i16, i16* %max, align 2, !cost !6
  ret i16 %16, !cost !6
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i16, i1 immarg) #2

declare dso_local i16 @printf(i8*, ...) #3

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { alwaysinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"45"}
!3 = !{!"DiscreteDistribution(5)"}
!4 = !{!"Intermittent Capacitor 100,2000"}
!5 = !{!"Intermittent Checkpoint"}
!6 = !{!"timing;;energy;"}
!7 = !{!"arr <- memory(5, 14, 18, 9)"}
!8 = !{!"n <- DiscreteDistribution(supp=1:4)"}
