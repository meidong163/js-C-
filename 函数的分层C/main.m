//
//  main.m
//  函数的分层C
//
//  Created by 没懂 on 16/5/22.
//  Copyright © 2016年 com.comelet. All rights reserved.
//

#import <Foundation/Foundation.h>

#include<string.h>

#pragma 业务中需要哪种计算，直接想来做

typedef enum : NSUInteger {
    PLUS = 0,
    MINUS,
    MULPLICATION,
} Calculate;

typedef struct {
    int (*p)(int,int);
    int res;
}CLASS;

#pragma 负责具体的计算
int plus(int a, int b){
    return a + b;
}

int minus(int a, int b){
    return  a - b;
}

int multiplication(int a, int b){
    return a * b;
}

 //要是能这样写，就好了，可惜函数指针不能作为函数返回值类型或者说函数的类型
//int（*calculate（Calculate type））（int,int） calculate(Calculate type){
//    switch (type) {
//        case PLUS:
//            return plus
//            break;
//        case MINUS:
//            return minus
//            break;
//        case MULPLICATION:
//            return multiplication
//            break;
//    }
//}


// 虽然，不能写函数指针但是可以这样写。
CLASS calculate1(Calculate type,int a,int b){
    switch (type) {
        case PLUS:
        {
            CLASS c;
            c.p = plus;
            c.res = plus(a,b);
            return c;
        }
            break;
        case MINUS:
        {
            CLASS c;
            c.p = minus;
            c.res = minus(a,b);
            return c;
        }
            break;
        case MULPLICATION:
        {
            CLASS c;
            c.p = multiplication;
            c.res = multiplication(a, b);
            return c;
        }
            break;
    }
}

// 所以要这样写

int calculate(int (*p)(int,int), int a, int b){
    // 回调
    return  p(a,b);
}

/****函数返回值要可以是函数指针，那么main中就可以这么写了*****/
void cal1()
{
    // 计算加
    int (*p1)(int,int) = plus;
    NSLog(@" plus = %d",calculate(p1, 5, 3));
    // 减
    int (*p2)(int,int) = minus;
    NSLog(@" minus = %d",calculate(p2, 5, 3));
    // 乘
    int (*p3)(int,int) = multiplication;
    NSLog(@" mulplication = %d",calculate(p3, 5, 3));
}

void cal2()
{
    // 这么干的好处是，业务层的代码少了。这层代码不关系，具体怎么计算的。
    // 计算加
    NSLog(@" plus = %d",calculate1(PLUS, 5, 3).res);
    // 计算减
    NSLog(@" minus = %d",calculate1(MINUS, 5, 3).res);
    // 计算乘
    NSLog(@" mulplication = %d",calculate1(MULPLICATION, 5, 3).res);
}

void Print(int *num, int n)
{
    int i;
    for(i = 0; i < n; i++)
        printf("%d ", num[i]);
    puts("\n");
    return;
}
//数字排序
void Bubble_Sort(int *num, int n)
{
    int i, j;
    for(i = 0; i < n; i++)
    {
        for(j = 0; i + j < n - 1; j++)
        {
            if(num[j] > num[j + 1])
            {
                int temp = num[j];
                num[j] = num[j + 1];
                num[j + 1] = temp;
            }
            Print(num, n);
        }
    }
    return;
}

int cmp_string(const void *a, const void *b)
{
    return strcmp(*((char **)a), *((char **)b));
}
// 字符串排序
void charPtrSort()
{
    char *a[] = {
        "shandong", "shanghai",
        "beijing", "wuhan",
        "shenzhen", "lianyungang",
        "diaoyudao", "nanshan",};
    int n = sizeof(a)/sizeof(char *);
    
    printf("排序前：\n");
    for (int i = 0; i < n; i++) {
        printf("%s ", a[i]);
    }
    printf("\n");
    
    qsort(a, n, sizeof(char *), cmp_string);
    
    printf("排序后：\n");
    for (int i = 0; i < n; i++) {
        printf("%s ", a[i]);
    }
    printf("\n");
}

int main(int argc, const char * argv[]) {
    
    cal1();
    cal2();
    
    int a[5] = {1,5,20,30,4};
    Bubble_Sort(a,  5);
    charPtrSort();
    return 0;
}


