# 🔁 Async FIFO RTL & Verification Project

A step-by-step journey from a synchronous FIFO to a fully verified,
CDC-safe asynchronous FIFO in SystemVerilog.

---

## 🎯 Goal

Build a robust, verification-ready asynchronous FIFO suitable for
real-world CDC design practice and interview-level projects.

---

## 🗺️ Roadmap

### ✅ Stage 1 — Synchronous FIFO (RTL)
- [x] Parameterized memory array (DATA_WIDTH / FIFO_DEPTH)
- [x] Read & write pointers with wrap-around bit
- [x] Full / empty logic
- [x] Simultaneous read & write support

### 🔄 Stage 2 — Synchronous FIFO (Verification)
- [ ] Directed testbench (write, read, full, empty, simultaneous)
- [ ] Random test scenarios
- [ ] Assertions (SVA) for full / empty correctness

### ⏳ Stage 3 — Async FIFO (RTL)
- [ ] Gray code pointers for CDC safety
- [ ] 2-FF synchronizers (write ↔ read domain)
- [ ] Full / empty logic across clock domains

### ⏳ Stage 4 — Async FIFO (Verification)
- [ ] Formal verification with SymbiYosys / JasperGold
- [ ] FIFO contract proof (two consecutive values)
- [ ] Cover properties (fill / drain)

---

## 📖 References

- [ZipCPU — Crossing clock domains with an Async FIFO](https://zipcpu.com/blog/2018/07/06/afifo.html)
