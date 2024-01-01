/* Define the entry point of the kernel */
ENTRY(_start)

/* Specify the architecture */
OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)

/* The memory layout of the kernel */
SECTIONS
{
    /* Set the start address of the kernel */
    . = 0x100000; /* Example address: 1MB */

    /* Text section */
    /* Contains the executable code */
    .text : {
        *(.text)         /* Include all .text sections from all files */
    }

    /* Read-only data section */
    .rodata : {
        *(.rodata*)      /* Include all read-only data */
    }

    /* Data section */
    /* Initialized data */
    .data : {
        *(.data)         /* Include all .data sections */
    }

    /* BSS section */
    /* Uninitialized data */
    .bss : {
        *(.bss)          /* Include all .bss sections */
        *(COMMON)        /* Include all common symbols */
    }

    /* Include other sections as needed... */

    /* End of the kernel */
    . = ALIGN(4096);    /* Align to page boundary */
    end = .;            /* Define 'end' symbol at this location */
}