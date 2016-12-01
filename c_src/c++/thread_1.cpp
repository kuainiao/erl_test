//
// Created by yj on 16-11-24.
//
//g++ thread_1.cpp -pthread -std=c++11

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <thread>
#include <iostream>
#include <vector>

using namespace std;

int k = 0;

void fun(void) {
    this_thread::sleep_for(std::chrono::seconds(3));
    for (int i = 0; i < 10; ++i) {
        cout << "hello world" << endl;
        k++;
    }
}

int main() {
//    thread t1(fun);
//    cout << "ID:" << t1.get_id() << endl;
//    cout << "CPU:" << thread::hardware_concurrency() << endl;
//    t1.join();
//    cout << k << endl;
//    return EXIT_SUCCESS;

    std::vector <thread> threads;
    for (int i = 0; i < 5; i++) {
        threads.push_back(thread([]() {
            cout << "hello from lamda thread" << this_thread::get_id() << endl;
        }));
    }

    for (auto &thread:threads) {
        thread.join();
    }
    cout << "main thread" << "\t" << this_thread::get_id() << endl;

}