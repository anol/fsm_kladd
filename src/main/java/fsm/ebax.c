
// Name: ebax.cpp
// Date: 20161031
// Sign: Testify-Aeo

#include "tp_external.h"
#include "ebax.h"
			
//=========================================================================
// Local Data
//=========================================================================

static int nMyTraceLevel = 1;
		

//=========================================================================
// Procedures used for Tracing
//=========================================================================

#define RETURN_STRING( CASE ) case CASE: return #CASE;

extern const char* ebax_Event2String(ebax_event_t nEvent) {
	switch (nEvent) {
		RETURN_STRING(on_Void)
		RETURN_STRING(on_button)
		RETURN_STRING(on_short_time)
		RETURN_STRING(on_SafetyAllow)
		RETURN_STRING(on_SafetyInhibit)
		RETURN_STRING(on_ExtendTimerExpired)
		RETURN_STRING(on_RetractTimerExpired)
		RETURN_STRING(on_MaxExtendedTimerExpired)
		RETURN_STRING(on_RequestHome)
		RETURN_STRING(on_RequestCompaction)
		RETURN_STRING(on_Max) 
	} 
	return "Error:ebaxIllegalEvent";
}

extern const char* ebax_Action2String(ebax_action_t nAction) { 
	switch (nAction) { 
		RETURN_STRING(do_Void)
		RETURN_STRING(do_Stop)
		RETURN_STRING(do_Extend)
		RETURN_STRING(do_Retract)
		RETURN_STRING(do_Confirm)
		RETURN_STRING(do_Reject)
		RETURN_STRING(do_StartExtendTimer)
		RETURN_STRING(do_StartRetractTimer)
		RETURN_STRING(do_StartMaxExtendedTimer)
		RETURN_STRING(do_Max)
	}
	return "Error:ebaxIllegalAction"; 
}

extern const char*ebax_State2String(ebax_state_t nState) { 
	switch (nState) { 
		RETURN_STRING(in_Void)
		RETURN_STRING(in_start)
		RETURN_STRING(in_stop)
		RETURN_STRING(in_ebax_abort)
		RETURN_STRING(in_ebax_account)
		RETURN_STRING(in_ebax_bankid)
		RETURN_STRING(in_ebax_old_user)
		RETURN_STRING(in_ebax_payment_complete)
		RETURN_STRING(in_ebax_pincode)
		RETURN_STRING(in_ebax_pincode_timeout)
		RETURN_STRING(in_ebax_progress)
		RETURN_STRING(in_ebax_register)
		RETURN_STRING(in_ebax_registration_completed)
		RETURN_STRING(in_ebax_wait)
		RETURN_STRING(in_bankid_personal_number)
		RETURN_STRING(in_bankid_one_time_code)
		RETURN_STRING(in_bankid_personal_password)
		RETURN_STRING(in_bankid_wait)
		RETURN_STRING(in_Max)
	}
	return "Error:ebaxIllegalState";
}

static void TraceEvent(ebax_event_t nOnEvent,ebax_state_t nInState,ebax_action_t nDoAction,ebax_state_t nToState) {
	if((do_Void != nDoAction)||(nInState != nToState)){
		tdprintf("%s: %s",ebax_State2String(nInState), ebax_Event2String(nOnEvent));
		if (do_Void != nDoAction) { 
			xprintf(" [%s]", ebax_Action2String(nDoAction)); 
		} 
		if (nInState != nToState) { 
			xprintf(" => %s", ebax_State2String(nToState)); }
			xprintf("\n"); 
	}
}
	
//=========================================================================
// Local Procedures used to implement the State Machine
//=========================================================================


static void FsmLookup(ebax_event_t nOnEvent,ebax_state_t nInState,ebax_action_t * pDoAction,ebax_state_t * pToState) {
	switch (nInState) {
		
//=========================================================================
		case in_start:
			switch (nOnEvent) {
			case on_immediate: *pDoAction =do_Void; *pToState =in_ebax_register; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_stop:
			switch (nOnEvent) {
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_abort:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_account:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_short_time: *pDoAction =do_Void; *pToState =in_ebax_payment_complete; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_bankid:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_bankid_wait; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_old_user:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_payment_complete:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_short_time: *pDoAction =do_Void; *pToState =in_stop; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_pincode:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_ebax_bankid; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_pincode_timeout:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_progress:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_register:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_ebax_pincode; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_registration_completed:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_ebax_wait:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_bankid_personal_number:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_bankid_one_time_code; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_bankid_one_time_code:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_bankid_personal_password; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_bankid_personal_password:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_button: *pDoAction =do_Void; *pToState =in_ebax_account; return;
			default:;
			} 
			break;
	
//=========================================================================
		case in_bankid_wait:
			switch (nOnEvent) {
			case on_EnterState: *pDoAction = do_onEnter; *pToState = nInState; return;
			case on_short_time: *pDoAction =do_Void; *pToState =in_bankid_personal_number; return;
			default:;
			} 
			break;
				
//=========================================================================
		default:;
	}
			
//==== Use any event specific default action ==============================					
	*pToState = nInState;
	switch (nOnEvent) {
		case on_RequestHome: *pDoAction = do_reject; return;
		case on_RequestCompaction: *pDoAction = do_reject; return;
		default:;
		}
		
//==== Use default action - ie. no action ================================					
	*pDoAction =do_Void;
}

	
		
//=========================================================================
// Exported Procedures
//=========================================================================


extern ebax_state_t ebax_Initialize(){
	return in_Start;
}
extern void ebax_SetTraceLevel(int nLevel){
	nMyTraceLevel = nLevel;
}
extern ebax_state_t ebax_OnEvent(ebax_event_t nOnEvent, ebax_state_t nInState, ebax_action_t *pDoAction){
	ebax_action_t nDoAction = do_Void;
	ebax_state_t nToState = nInState; 
	FsmLookup(nOnEvent, nInState, &nDoAction, &nToState); 
	if (nMyTraceLevel) { 
		TraceEvent(nOnEvent, nInState, nDoAction, nToState); 
	}
	*pDoAction = nDoAction; 
	return nToState; 
} 
				