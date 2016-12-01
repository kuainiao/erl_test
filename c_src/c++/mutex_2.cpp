//
// Created by yj on 16-11-25.
//

#include <iostream>
#include <thread>
#include <future>
#include <string>

std::promise<int> prom;

void print_global_promise() {
    std::future<int> fut = prom.get_future();
    int x = fut.get();
    std::cout << "value: " << x << std::endl;
}

int main() {
    std::thread t1(print_global_promise);
    prom.set_value(10);
    t1.join();

    prom = std::promise<int>();

    std::thread t2(print_global_promise);
    prom.set_value(20);
    t2.join();


    std::string s1 = "aabbcc我们";
    std::cout << s1.length() << std::endl;
    return 0;
}