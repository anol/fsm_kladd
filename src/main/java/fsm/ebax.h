
// Name: ebax.cpp
// Date: 20161031
// Sign: Testify-Aeo
			
#ifndef ebax_H_
#define ebax_H_

typedef enum {
	on_Void=0,
	on_button,
	on_short_time,
	on_SafetyAllow,
	on_SafetyInhibit,
	on_ExtendTimerExpired,
	on_RetractTimerExpired,
	on_MaxExtendedTimerExpired,
	on_RequestHome,
	on_RequestCompaction,
	on_Max
}ebax_event_t ;

typedef enum {
	do_Void=0,
	do_Stop,
	do_Extend,
	do_Retract,
	do_Confirm,
	do_Reject,
	do_StartExtendTimer,
	do_StartRetractTimer,
	do_StartMaxExtendedTimer,
	do_Max
}ebax_action_t ;

typedef enum {
	in_Void=0,
	in_start,
	in_stop,
	in_ebax_abort,
	in_ebax_account,
	in_ebax_bankid,
	in_ebax_old_user,
	in_ebax_payment_complete,
	in_ebax_pincode,
	in_ebax_pincode_timeout,
	in_ebax_progress,
	in_ebax_register,
	in_ebax_registration_completed,
	in_ebax_wait,
	in_bankid_personal_number,
	in_bankid_one_time_code,
	in_bankid_personal_password,
	in_bankid_wait,
	in_Max
}ebax_state_t ;

extern ebax_state_t ebax_Initialize();
extern void ebax_SetTraceLevel(int nLevel);
extern const char* ebax_Event2String(ebax_event_t  nEvent);
extern const char* ebax_Action2String(ebax_action_t  nAction);
extern const char* ebax_State2String(ebax_state_t  nState);
extern ebax_state_t ebax_OnEvent(ebax_event_t nOnEvent, ebax_state_t nInState, ebax_action_t *pDoAction);
		
#endif /* ebax_H_ */
