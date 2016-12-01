//
// Created by yj on 16-11-25.
//

#include <iostream>
#include <thread>
#include <mutex>
#include <stdexcept>

volatile int counter(0);
std::mutex mtx;
std::timed_mutex tmtx;

void print_block(int n, char c) {
    std::unique_lock <std::mutex> lck(mtx);
    for (int i = 0; i < n; i++) {
        std::cout << c;
    }
    std::cout << "\n";
}

void print_even(int x) {
    if (x % 2 == 0) {
        std::cout << x << " is event" << std::endl;
    } else {
        throw (std::logic_error("not even"));
    }
}

void print_thread_id(int id) {
    try {
        std::lock_guard <std::mutex> lck(mtx);
        print_even(id);
    }
    catch (std::logic_error &) {
        std::cout << "[exception caught]\n";
    }
}

void fireworks() {
    while (!tmtx.try_lock_for(std::chrono::milliseconds(199))) {
        std::cout << "-";
    }
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    std::cout << "*\n";
    tmtx.unlock();
}

void attempt_10k_increases() {
    for (int i = 0; i < 10000; ++i) {
        if (mtx.try_lock()) {
            ++counter;
            mtx.unlock();
        }
    }
}

int main(int argc, const char *argv[]) {
//    std::thread threads[10];
//    for (int i = 0; i < 10; i++) {
//        threads[i] = std::thread(print_thread_id, i + 1);
//    }
//    for (auto &th:threads) th.join();
////    std::cout << counter << "successful increases of the counter" << std::endl;
    std::thread t1(print_block, 50, '*');
    std::thread t2(print_block, 50, '$');

    t1.join();
    t2.join();

    return 0;
}
