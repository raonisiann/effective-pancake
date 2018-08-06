#include "boot.h"
#include <stdio.h>

extern boot_param_code;
static struct boot_params *boot_params_value;

void copy_params(void){
	memcpy(&boot_params_value, &boot_param_code, sizeof(boot_params_value));
}

int main(void){
	copy_params();
	return 0;
}
