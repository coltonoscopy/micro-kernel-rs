# micro-kernel-rs

Just an experiment I've been working on to learn more about Rust and OS development. Maybe it needs a rename
in the future, but for now I'm just keeping it matter-of-fact :)

## Current Status

Compiles, doesn't boot. Need to write a bootloader in x86 assembly to get it to boot, which I have the initial
rough undertanding and scaffolding for but have to test. It's pretty complicated and also only scaffolded for
32-bit operation and I would *like* it to be 64-bit, so I have to kind of flesh that out once 32-bit support works.
All this stuff is kind of a wacky rabbithole, but it's been super fun.

## Build

```bash
cargo build --target x86_64-micro-kernel-rs.json -Zbuild-std=core,compiler_builtins
```

## Run

(assumes a Windows environment, since that's what I've been using and haven't investigated differences on other systems atm)

1) Install QEMU
2) Run `qemu-system-x86_64 -drive format=raw,file=target/x86_64-micro-kernel-rs/debug/bootimage-micro-kernel-rs.bin`

## Motivation

An eventual goal I would *like* to get to is writing a completely from-scratch web server,
including the OS code it's hosted on, specifically in Rust both to get very comfortable with Rust as well as
to truly understand the ins and outs of what goes on underneath the layers of modern development.
I never really studied OS dev or anything like that in school or for work, but I've always had a sort of
fascination with programming for older systems, like the Nintendo 64 (a separate Rust project I've been
tinkering with), because of my interest in games. I've tinkered with various tiny homebrew game projects
for some older hardware like GBA, GB, and NES, but nothing substantial (yet).

I mostly work in the web world for work, with the modern ecosystems of Node.js, React, and the like.
They're great tools and it's easy to be productive with them, but there's inevitably a bit of a disconnect
as well as a performance hit when you're working with these higher-level languages and frameworks. But
knowing just how much, as well as what can be done about it, as well as what's possible with a more modern
low-level language, is a super fun and interesting prospect for me. Practically speaking, I don't think
being so low-level to this extent is necessary for most web development, but it's still a fun thing to
learn about and may have some useful applications with Rust-based microservices and the like.

Tools like Chat-GPT are super cool nowadays for deep-diving things like this. GPT-4 specifically over 3.5,
though before long we'll have GPT-5. But for anyone interested these days in really learning or developing
something substantial, I can't recommend it enough. That coupled with Copilot has really helped lift me to
where I can dig into these things without getting heavily burned out on just the research phase. What exists
so far in this repo is in huge part a result of several very long but fun said chat sessions.
