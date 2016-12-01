//
// Created by yj on 16-11-24.
//

#include <mutex>
#include <thread>
#include <iostream>
#include <vector>

using namespace std;


struct Counter {
    std::mutex mutex;
    int value;

    Counter() : value(0) {}

    void increment() {
        ++value;
    }

    void decrement() {
        mutex.lock();
        --value;
        mutex.unlock();
    }
};

void f1(int n) {
    for (int i = 0; i < 5; ++i) {
        cout << "Thread " << n << "executiong" << endl;
        this_thread::sleep_for(chrono::milliseconds(10));
    }
}

void f2(int &n) {
    for (int i = 0; i < 5; ++i) {
        cout << "Thread 2 execution" << endl;
        ++n;
        this_thread::sleep_for(chrono::milliseconds(10));
    }
}

void thread_task(int n) {
    this_thread::sleep_for(chrono::seconds(n));
    cout << "thread id:" << this_thread::get_id() << " N:" << n << "seconds" << endl;
}

int main() {
    int n = 0;
    thread t1;
    thread t2(f1, n + 1);
    thread t3(f2, ref(n));
    thread t4(move(t3));
    t2.join();
    t4.join();
    cout << "final value of n is " << n << endl;

    thread threads[5];
    cout << "spawning 5 threads..." << endl;
    for (int i = 0; i < 5; i++) {
        threads[i] = thread(thread_task, i + 1);
    }
    cout << "Done spawning threads! now wait for them to join" << endl;
    for (auto &t:threads) {
        t.join();
    }
    cout << "all threads joined." << endl;
    return EXIT_SUCCESS;

    return 0;
}

//int main() {
////    mutex m;
////    thread t1([&m]() {
////        this_thread::sleep_for(chrono::seconds(10));
////        for (int i = 0; i < 10; i++) {
////            m.lock();
////            cout << "thread_id:" << this_thread::get_id() << ":" << i << endl;
////            m.unlock();
////        }
////    });
////
////    thread t2([&m]() {
////        this_thread::sleep_for(chrono::seconds(1));
////        for (int i = 0; i < 10; i++) {
////            m.lock();
////            cout << "t2 thread_id:" << this_thread::get_id() << ":" << i << endl;
////            m.unlock();
////        }
////    });
////
////    t1.join();
////    t2.join();
////
////    cout << "main thread" << endl;
//
//
//    Counter counter;
//    vector <thread> threads;
//    for (int i = 0; i < 5; i++) {
//        threads.push_back(thread([&]() {
//            for (int i = 0; i < 100; i++) {
//                counter.increment();
//            }
//        }));
//    }
//
//    for (auto &thread:threads) {
//        thread.join();
//    }
//    cout << counter.value << endl;
//
//    return 0;
//}