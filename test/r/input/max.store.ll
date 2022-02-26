; ModuleID = 'test/r/input/max.ll'
source_filename = "./input/max.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 10, i32 324, i32 45, i32 90, i32 9808], align 16, !global !0
@.str = private unnamed_addr constant [29 x i8] c"Largest in given array is %d\00", align 1, !global !1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @largest(i32* %arr, i32 %n) #0 !distribution !4 !distribution !5 !store !6 !formal !4 !formal !5 {
entry:
  %arrayidx = getelementptr inbounds i32, i32* %arr, i64 0, !store !7
  %0 = load i32, i32* %arrayidx, align 4, !store !8
  br label %for.cond, !store !9

for.cond:                                         ; preds = %for.inc, %entry
  %max.0 = phi i32 [ %0, %entry ], [ %max.1, %for.inc ], !store !10
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ], !store !11
  %cmp = icmp slt i32 %i.0, %n, !store !12
  br i1 %cmp, label %for.body, label %for.end, !store !13, !update !14

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64, !store !15, !undo !16
  %arrayidx1 = getelementptr inbounds i32, i32* %arr, i64 %idxprom, !store !17
  %1 = load i32, i32* %arrayidx1, align 4, !store !18
  %cmp2 = icmp sgt i32 %1, %max.0, !store !19
  br i1 %cmp2, label %if.then, label %if.end, !store !20, !update !21

if.then:                                          ; preds = %for.body
  %idxprom3 = sext i32 %i.0 to i64, !store !22, !undo !23
  %arrayidx4 = getelementptr inbounds i32, i32* %arr, i64 %idxprom3, !store !24
  %2 = load i32, i32* %arrayidx4, align 4, !store !25
  br label %if.end, !store !26

if.end:                                           ; preds = %if.then, %for.body
  %max.1 = phi i32 [ %2, %if.then ], [ %max.0, %for.body ], !store !27, !undo !28
  br label %for.inc, !store !29

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1, !store !30
  br label %for.cond, !store !9

for.end:                                          ; preds = %for.cond
  ret i32 %max.0, !store !31, !undo !32
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #1 !store !33 {
entry:
  %arr.addr.i = alloca i32*, align 8, !store !34
  %n.addr.i = alloca i32, align 4, !store !35
  %max.i = alloca i32, align 4, !store !36
  %i.i = alloca i32, align 4, !store !37
  %retval = alloca i32, align 4, !store !38
  %arr = alloca [5 x i32], align 16, !store !39
  %n = alloca i32, align 4, !store !40
  %max = alloca i32, align 4, !store !41
  store i32 0, i32* %retval, align 4, !store !42
  %0 = bitcast [5 x i32]* %arr to i8*, !store !43
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([5 x i32]* @__const.main.arr to i8*), i64 20, i1 false), !store !44
  store i32 5, i32* %n, align 4, !store !45
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0, !store !46
  %1 = load i32, i32* %n, align 4, !store !47
  store i32* %arraydecay, i32** %arr.addr.i, align 8, !store !48
  store i32 %1, i32* %n.addr.i, align 4, !store !49
  %2 = load i32*, i32** %arr.addr.i, align 8, !store !50
  %3 = load i32, i32* %2, align 4, !store !51
  store i32 %3, i32* %max.i, align 4, !store !52
  store i32 1, i32* %i.i, align 4, !store !53
  br label %for.cond.i, !store !54

for.cond.i:                                       ; preds = %if.end.i, %entry
  %4 = load i32, i32* %i.i, align 4, !store !55
  %5 = load i32, i32* %n.addr.i, align 4, !store !56
  %cmp.i = icmp slt i32 %4, %5, !store !57
  br i1 %cmp.i, label %for.body.i, label %largest.exit, !store !58, !update !59

for.body.i:                                       ; preds = %for.cond.i
  %6 = load i32*, i32** %arr.addr.i, align 8, !store !60, !undo !61
  %7 = load i32, i32* %i.i, align 4, !store !62
  %idxprom.i = sext i32 %7 to i64, !store !63
  %arrayidx1.i = getelementptr inbounds i32, i32* %6, i64 %idxprom.i, !store !64
  %8 = load i32, i32* %arrayidx1.i, align 4, !store !65
  %9 = load i32, i32* %max.i, align 4, !store !66
  %cmp2.i = icmp sgt i32 %8, %9, !store !67
  br i1 %cmp2.i, label %if.then.i, label %if.end.i, !store !68, !update !69

if.then.i:                                        ; preds = %for.body.i
  %10 = load i32*, i32** %arr.addr.i, align 8, !store !70, !undo !71
  %11 = load i32, i32* %i.i, align 4, !store !72
  %idxprom3.i = sext i32 %11 to i64, !store !73
  %arrayidx4.i = getelementptr inbounds i32, i32* %10, i64 %idxprom3.i, !store !74
  %12 = load i32, i32* %arrayidx4.i, align 4, !store !75
  store i32 %12, i32* %max.i, align 4, !store !76
  br label %if.end.i, !store !77

if.end.i:                                         ; preds = %if.then.i, %for.body.i
  %13 = load i32, i32* %i.i, align 4, !store !78, !undo !79
  %inc.i = add nsw i32 %13, 1, !store !80
  store i32 %inc.i, i32* %i.i, align 4, !store !81
  br label %for.cond.i, !store !54

largest.exit:                                     ; preds = %for.cond.i
  %14 = load i32, i32* %max.i, align 4, !store !82, !undo !83
  store i32 %14, i32* %max, align 4, !store !84
  %15 = load i32, i32* %max, align 4, !store !85
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i64 0, i64 0), i32 %15)
  %16 = load i32, i32* %max, align 4, !store !86
  ret i32 %16, !store !87
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local i32 @printf(i8*, ...) #3

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{!"c.__const.main.arr <- env(\\\220\\\22 = 10, \\\221\\\22 = 324, \\\222\\\22 = 45, \\\223\\\22 = 90, \\\224\\\22 = 9808)"}
!1 = !{!"c..str <- env(\\\220\\\22 = 76, \\\221\\\22 = 97, \\\222\\\22 = 114, \\\223\\\22 = 103, \\\224\\\22 = 101, \\\225\\\22 = 115, \\\226\\\22 = 116, \\\227\\\22 = 32, \\\228\\\22 = 105, \\\229\\\22 = 110, \\\2210\\\22 = 32, \\\2211\\\22 = 103, \\\2212\\\22 = 105, \\\2213\\\22 = 118, \\\2214\\\22 = 101, \\\2215\\\22 = 110, \\\2216\\\22 = 32, \\\2217\\\22 = 97, \\\2218\\\22 = 114, \\\2219\\\22 = 114, \\\2220\\\22 = 97, \\\2221\\\22 = 121, \\\2222\\\22 = 32, \\\2223\\\22 = 105, \\\2224\\\22 = 115, \\\2225\\\22 = 32, \\\2226\\\22 = 37, \\\2227\\\22 = 100, \\\2228\\\22 = 0)"}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!4 = !{!"arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"}
!5 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!6 = !{!"entry <- F; for.cond <- F; for.body <- F; if.then <- F; if.end <- F; for.inc <- F; for.end <- F"}
!7 = !{!"p.arrayidx <- gep(ptr(arr), 0)"}
!8 = !{!"v.0 <- load(p.arrayidx)"}
!9 = !{!"br(for.cond)"}
!10 = !{!"v.max.0 <- if (entry) v.0 else if (for.inc) v.max.1"}
!11 = !{!"v.i.0 <- if (entry) 1 else if (for.inc) v.inc"}
!12 = !{!"v.cmp <- icmp(slt, v.i.0, n)"}
!13 = !{!"br(for.body, for.end, v.cmp)"}
!14 = !{!"v.i.0 <- add(v.cmp, n); n <- sub(v.i.0, v.cmp); "}
!15 = !{!"v.idxprom <- sext(v.i.0)"}
!16 = !{!"if(for.cond) {v.cmp <- v.cmp.true; v.i.0 <- add(v.cmp, n); n <- sub(v.i.0, v.cmp); };"}
!17 = !{!"p.arrayidx1 <- gep(ptr(arr), v.idxprom)"}
!18 = !{!"v.1 <- load(p.arrayidx1)"}
!19 = !{!"v.cmp2 <- icmp(sgt, v.1, v.max.0)"}
!20 = !{!"br(if.then, if.end, v.cmp2)"}
!21 = !{!"v.1 <- add(v.cmp2, v.max.0); store(v.1, p.arrayidx1); v.max.0 <- sub(v.1, v.cmp2); "}
!22 = !{!"v.idxprom3 <- sext(v.i.0)"}
!23 = !{!"if(for.body) {v.cmp2 <- v.cmp2.true; v.1 <- add(v.cmp2, v.max.0); store(v.1, p.arrayidx1); v.max.0 <- sub(v.1, v.cmp2); };"}
!24 = !{!"p.arrayidx4 <- gep(ptr(arr), v.idxprom3)"}
!25 = !{!"v.2 <- load(p.arrayidx4)"}
!26 = !{!"br(if.end)"}
!27 = !{!"v.max.1 <- if (if.then) v.2 else if (for.body) v.max.0"}
!28 = !{!"if(for.body) {v.cmp2 <- v.cmp2.false; v.1 <- add(v.cmp2, v.max.0); store(v.1, p.arrayidx1); v.max.0 <- sub(v.1, v.cmp2); };"}
!29 = !{!"br(for.inc)"}
!30 = !{!"v.inc <- add(v.i.0, 1)"}
!31 = !{!"path.return <<- c(path.return, ret(v.max.0)); for.end <- T; for.cond <- F"}
!32 = !{!"if(for.cond) {v.cmp <- v.cmp.false; v.i.0 <- add(v.cmp, n); n <- sub(v.i.0, v.cmp); };"}
!33 = !{!"entry <- F; for.cond.i <- F; for.body.i <- F; if.then.i <- F; if.end.i <- F; largest.exit <- F"}
!34 = !{!"p.arr.addr.i <- alloca(\\\22int*\\\22)"}
!35 = !{!"p.n.addr.i <- alloca(\\\22int\\\22)"}
!36 = !{!"p.max.i <- alloca(\\\22int\\\22)"}
!37 = !{!"p.i.i <- alloca(\\\22int\\\22)"}
!38 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!39 = !{!"p.arr <- alloca(\\\22array\\\22)"}
!40 = !{!"p.n <- alloca(\\\22int\\\22)"}
!41 = !{!"p.max <- alloca(\\\22int\\\22)"}
!42 = !{!"store(0, p.retval)"}
!43 = !{!"p.0 <- bitcast(p.arr)"}
!44 = !{!"memcpy(p.0, ptr(c.__const.main.arr))"}
!45 = !{!"store(5, p.n)"}
!46 = !{!"p.arraydecay <- gep(p.arr, 0, 0)"}
!47 = !{!"v.1 <- load(p.n)"}
!48 = !{!"store(p.arraydecay, p.arr.addr.i)"}
!49 = !{!"store(v.1, p.n.addr.i)"}
!50 = !{!"p.2 <- load(p.arr.addr.i)"}
!51 = !{!"v.3 <- load(p.2)"}
!52 = !{!"store(v.3, p.max.i)"}
!53 = !{!"store(1, p.i.i)"}
!54 = !{!"br(for.cond.i)"}
!55 = !{!"v.4 <- load(p.i.i)"}
!56 = !{!"v.5 <- load(p.n.addr.i)"}
!57 = !{!"v.cmp.i <- icmp(slt, v.4, v.5)"}
!58 = !{!"br(for.body.i, largest.exit, v.cmp.i)"}
!59 = !{!"v.4 <- add(v.cmp.i, v.5); store(v.4, p.i.i); v.5 <- sub(v.4, v.cmp.i); store(v.5, p.n.addr.i); "}
!60 = !{!"p.6 <- load(p.arr.addr.i)"}
!61 = !{!"if(for.cond.i) {v.cmp.i <- v.cmp.i.true; v.4 <- add(v.cmp.i, v.5); store(v.4, p.i.i); v.5 <- sub(v.4, v.cmp.i); store(v.5, p.n.addr.i); };"}
!62 = !{!"v.7 <- load(p.i.i)"}
!63 = !{!"v.idxprom.i <- sext(v.7)"}
!64 = !{!"p.arrayidx1.i <- gep(p.6, v.idxprom.i)"}
!65 = !{!"v.8 <- load(p.arrayidx1.i)"}
!66 = !{!"v.9 <- load(p.max.i)"}
!67 = !{!"v.cmp2.i <- icmp(sgt, v.8, v.9)"}
!68 = !{!"br(if.then.i, if.end.i, v.cmp2.i)"}
!69 = !{!"v.8 <- add(v.cmp2.i, v.9); store(v.8, p.arrayidx1.i); store(p.6, p.arr.addr.i); store(v.7, p.i.i); v.9 <- sub(v.8, v.cmp2.i); store(v.9, p.max.i); "}
!70 = !{!"p.10 <- load(p.arr.addr.i)"}
!71 = !{!"if(for.body.i) {v.cmp2.i <- v.cmp2.i.true; v.8 <- add(v.cmp2.i, v.9); store(v.8, p.arrayidx1.i); store(p.6, p.arr.addr.i); store(v.7, p.i.i); v.9 <- sub(v.8, v.cmp2.i); store(v.9, p.max.i); };"}
!72 = !{!"v.11 <- load(p.i.i)"}
!73 = !{!"v.idxprom3.i <- sext(v.11)"}
!74 = !{!"p.arrayidx4.i <- gep(p.10, v.idxprom3.i)"}
!75 = !{!"v.12 <- load(p.arrayidx4.i)"}
!76 = !{!"store(v.12, p.max.i)"}
!77 = !{!"br(if.end.i)"}
!78 = !{!"v.13 <- load(p.i.i)"}
!79 = !{!"if(for.body.i) {v.cmp2.i <- v.cmp2.i.false; v.8 <- add(v.cmp2.i, v.9); store(v.8, p.arrayidx1.i); store(p.6, p.arr.addr.i); store(v.7, p.i.i); v.9 <- sub(v.8, v.cmp2.i); store(v.9, p.max.i); };"}
!80 = !{!"v.inc.i <- add(v.13, 1)"}
!81 = !{!"store(v.inc.i, p.i.i)"}
!82 = !{!"v.14 <- load(p.max.i)"}
!83 = !{!"if(for.cond.i) {v.cmp.i <- v.cmp.i.false; v.4 <- add(v.cmp.i, v.5); store(v.4, p.i.i); v.5 <- sub(v.4, v.cmp.i); store(v.5, p.n.addr.i); };"}
!84 = !{!"store(v.14, p.max)"}
!85 = !{!"v.15 <- load(p.max)"}
!86 = !{!"v.16 <- load(p.max)"}
!87 = !{!"path.return <<- c(path.return, ret(v.16)); largest.exit <- T; for.cond.i <- F"}
