/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */
typedef enum  
{
	STOP,
	FORWARD,
	BACKWARD,
	LEFT_FORWARD,
	RIGHT_FORWARD,
	LEFT_BACK,
	RIGHT_BACK
}dc_control_t;
/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define LED_Pin GPIO_PIN_13
#define LED_GPIO_Port GPIOC
#define IN4_Pin GPIO_PIN_7
#define IN4_GPIO_Port GPIOA
#define IN3_Pin GPIO_PIN_0
#define IN3_GPIO_Port GPIOB
#define IN2_Pin GPIO_PIN_1
#define IN2_GPIO_Port GPIOB
#define IN1_Pin GPIO_PIN_10
#define IN1_GPIO_Port GPIOB
#define TRIG_Pin GPIO_PIN_12
#define TRIG_GPIO_Port GPIOA
#define ECHO_Pin GPIO_PIN_15
#define ECHO_GPIO_Port GPIOA
#define IR_LEFT_Pin GPIO_PIN_3
#define IR_LEFT_GPIO_Port GPIOB
#define IR_RIGHT_Pin GPIO_PIN_4
#define IR_RIGHT_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
