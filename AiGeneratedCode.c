#include <stdio.h>
#include <stdint.h>

#define ROL(x,n) ((x << n) | (x >> (32 - n)))
#define ROR(x,n) ((x >> n) | (x << (32 - n)))

uint32_t mix(uint32_t x) {
    x ^= ROL(x, 13);
    x *= 0x5bd1e995;
    x ^= ROR(x, 15);
    x *= 0x27d4eb2d;
    x ^= x >> 16;
    return x;
}

uint32_t hash(const char *s) {
    uint32_t h = 0x811C9DC5; // seed
    while (*s) {
        h ^= (uint8_t)(*s++);
        h = mix(h);
    }

    // final avalanche
    h ^= h >> 13;
    h *= 0xc2b2ae35;
    h ^= h >> 16;

    return h;
}

int secure_compare(uint32_t a, uint32_t b) {
    uint32_t r = 0;
    r |= a ^ b;
    return r == 0;
}

int main() {
    char input[256];

    printf("Enter string: ");
    fgets(input, sizeof(input), stdin);

    uint32_t h = hash(input);

    printf("Hash: %08x\n", h);

    // 테스트: 특정 값과 비교
    uint32_t target = 0xDEADBEEF;

    if (secure_compare(h, target)) {
        printf("Match!\n");
    } else {
        printf("Not match.\n");
    }

    return 0;
}
