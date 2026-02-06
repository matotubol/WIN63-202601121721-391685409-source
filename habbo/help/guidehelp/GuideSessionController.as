package com.sulake.habbo.help.guidehelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionStartedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionPartnerIsTypingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideOnDutyStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionAttachedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionErrorMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionEndedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionMessageMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionStartedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionInvitedToGuideRoomMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionResultsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionRequesterRoomMessageEventParser;
   import com.sulake.habbo.help.GuideHelpManager;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IIlluminaChatBubbleWidget;
   import com.sulake.habbo.window.widgets.IIlluminaInputHandler;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_2728;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import mx.utils.StringUtil;
   import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionMessageMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideOnDutyStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionStartedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionOfferedToGuideMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionRequesterRoomMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionPartnerIsTypingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionInvitedToGuideRoomMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionVotingStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionResultsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionDetachedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionAttachedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionDetachedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionResolvedMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionInviteRequesterMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionReportMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionOnDutyUpdateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDecidesOnOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGuideDecidesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideVoteMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionCreateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGetRequesterRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionFeedbackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionIsTypingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDetachedMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionRequesterCancelsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class GuideSessionController implements class_13, IIlluminaInputHandler
   {
      
      private static const SYSTEM_MSG_CHAT:int = 0;
      
      private static const SYSTEM_MSG_NOTIFICATION:int = 1;
      
      private static const SYSTEM_MSG_REMINDER:int = 2;
      
      private static const CHAT_MSG_DEFAULT:int = 0;
      
      private static const CHAT_MSG_INVITE:int = 1;
      
      private static const CHAT_MSG_SYSTEM:int = 2;
      
      private static const CHAT_REVIEW_VOTE_NONE:int = -1;
      
      private static const CHAT_REVIEW_VOTE_OK:int = 0;
      
      private static const CHAT_REVIEW_VOTE_BAD:int = 1;
      
      private static const CHAT_REVIEW_VOTE_VERY_BAD:int = 2;
      
      private static const const_163:int = 3000;
      
      private static const const_1102:int = 500;
      
      private static const STATUS_KEY_PREFIX:String = "${guide.bully.request.guide.results.outcome.";
      
      private static const STATUS_ICON_PREFIX:String = "help_chat_review_decision_";
      
      private static const STATUS_KEYS:Array = ["waiting","ok","bad","very_bad","refused","searching"];
      
      private static const RESULT_KEYS:Array = ["waiting","ok","bad","very_bad","inconclusive","searching"];
      
      private var _habboHelp:HabboHelp;
      
      private var _guideHelp:GuideHelpManager;
      
      private var _window:class_1812;
      
      private var var_341:class_1812;
      
      private var _sessionData:GuideSessionData;
      
      private var var_1890:Point = new Point(120,80);
      
      private var _onDuty:Boolean = false;
      
      private var var_1343:Boolean;
      
      private var var_1301:Boolean;
      
      private var var_1299:Boolean;
      
      private var var_4929:Boolean = false;
      
      private var _chatMsg:class_2010;
      
      private var var_1901:class_1812;
      
      private var var_4513:class_1812;
      
      private var _disposed:Boolean = false;
      
      private var var_715:Timer;
      
      private var _lastMessageTypedLength:int;
      
      private var _lastTypingInfo:Boolean;
      
      private var var_1142:Timer;
      
      private var var_864:Vector.<AnimationData>;
      
      private var var_1260:Timer;
      
      private var var_2770:int;
      
      public function GuideSessionController(param1:GuideHelpManager)
      {
         super();
         _habboHelp = param1.habboHelp;
         _guideHelp = param1;
         _sessionData = new GuideSessionData();
         _chatMsg = class_2010(_habboHelp.getXmlWindow("chat_msg"));
         var_1901 = class_1812(_habboHelp.getXmlWindow("chat_msg_notification"));
         var_4513 = class_1812(_habboHelp.getXmlWindow("chat_msg_reminder"));
         var_1343 = _habboHelp.getBoolean("guidetool.handle.help_requests");
         var_1301 = _habboHelp.getBoolean("guidetool.handle.chat_reviews");
         var_1299 = _habboHelp.getBoolean("guidetool.handle.tour_requests");
         _habboHelp.context.displayObjectContainer.stage.addEventListener("mouseMove",onStageMouseMove);
         var_864 = new Vector.<AnimationData>();
         var_1142 = new Timer(500);
         var_1142.addEventListener("timer",onWaitingAnimationTimer);
         var_1142.start();
         var_2770 = getTimer();
         var_1260 = new Timer(5000);
         var_1260.addEventListener("timer",onIdleCheckTimer);
         var_1260.start();
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionPartnerIsTypingMessageEvent(onGuideSessionPartnerIsTyping));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionDetachedMessageEvent(onGuideSessionDetached));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionRequesterRoomMessageEvent(onGuideSessionRequesterRoom));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionMessageMessageEvent(onGuideSessionMessage));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionEndedMessageEvent(onGuideSessionEnded));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionOfferedToGuideMessageEvent(onChatReviewSessionOfferedToGuide));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionResultsMessageEvent(onChatReviewSessionResults));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionStartedMessageEvent(onGuideSessionStarted));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionDetachedMessageEvent(onChatReviewSessionDetached));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionVotingStatusMessageEvent(onChatReviewSessionVotingStatus));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionErrorMessageEvent(onGuideSessionError));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionAttachedMessageEvent(onGuideSessionAttached));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionStartedMessageEvent(onChatReviewSessionStarted));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionInvitedToGuideRoomMessageEvent(onGuideSessionInvitedToGuideRoom));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideOnDutyStatusMessageEvent(onGuideOnDutyStatus));
      }
      
      private static function statusFromVote(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - -1)
         {
            case 0:
               _loc2_ = 4;
               break;
            case 1:
               _loc2_ = 1;
               break;
            case 2:
               _loc2_ = 2;
               break;
            case 3:
               _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_1260 != null)
         {
            var_1260.stop();
            var_1260.removeEventListener("timer",onIdleCheckTimer);
            var_1260 = null;
         }
         if(var_1142 != null)
         {
            var_1142.stop();
            var_1142.removeEventListener("timer",onWaitingAnimationTimer);
            var_1142 = null;
         }
         var_864 = null;
         if(_chatMsg)
         {
            _chatMsg.dispose();
            _chatMsg = null;
         }
         if(var_1901)
         {
            var_1901.dispose();
            var_1901 = null;
         }
         closeWindow();
         _sessionData = null;
         var_1890 = null;
         _guideHelp = null;
         if(_habboHelp && _habboHelp.context && _habboHelp.context.displayObjectContainer)
         {
            _habboHelp.context.displayObjectContainer.stage.removeEventListener("mouseMove",onStageMouseMove);
         }
         _habboHelp = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function createHelpRequest(param1:uint) : void
      {
         if(_sessionData.isActiveSession())
         {
            class_21.log("Can\'t create a new help request while another help request is ongoing");
            return;
         }
         if(param1 == 0 || param1 == 2)
         {
            _sessionData.role = 2;
            _sessionData.activeWindow = "user_create";
            _sessionData.requestType = param1;
            _habboHelp.sendMessage(new GuideSessionCreateMessageComposer(param1,_habboHelp.localization.getLocalization("guide.help.request.tour.description")));
         }
         else
         {
            setStateUserCreateRequest(param1);
         }
      }
      
      public function showGuideTool() : void
      {
         _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(_onDuty,var_1299,var_1343,var_1301));
      }
      
      private function onGuideOnDutyStatus(param1:GuideOnDutyStatusMessageEvent) : void
      {
         var _loc2_:GuideOnDutyStatusMessageEventParser = param1.getParser();
         _onDuty = _loc2_.onDuty;
         _habboHelp.localization.registerParameter("guide.help.guide.tool.guidesonduty","amount",_loc2_.guidesOnDuty.toString());
         _habboHelp.localization.registerParameter("guide.help.guide.tool.helpersonduty","amount",_loc2_.helpersOnDuty.toString());
         _habboHelp.localization.registerParameter("guide.help.guide.tool.guardiansonduty","amount",_loc2_.guardiansOnDuty.toString());
         setStateGuideTool();
      }
      
      private function onGuideSessionAttached(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionAttached");
         if(_disposed || !_sessionData)
         {
            class_21.log("_diposed or no _sessionData");
            return;
         }
         var _loc2_:GuideSessionAttachedMessageEventParser = param1.parser as GuideSessionAttachedMessageEventParser;
         if(_loc2_.asGuide)
         {
            if(_sessionData.isActiveGuideSession())
            {
               setStateError();
               return;
            }
            setStateGuideAccept(_loc2_.helpRequestType,_loc2_.helpRequestDescription,_loc2_.roleSpecificWaitTime);
         }
         else
         {
            if(!_sessionData.isActiveUserSession())
            {
               setStateError();
               return;
            }
            setStateUserPendingRequest(_loc2_.helpRequestType,_loc2_.helpRequestDescription,_loc2_.roleSpecificWaitTime);
         }
      }
      
      private function onGuideSessionDetached(param1:IMessageEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         class_21.log("onGuideSessionDetached");
         if(_disposed)
         {
            return;
         }
         if(var_4929)
         {
            _loc2_ = int(_sessionData.requestType);
            _loc3_ = _sessionData.requestDescription;
            resetSessionData();
            setStateUserCreateRequest(_loc2_,_loc3_);
         }
         else if(_sessionData.isActiveUserSession() && _sessionData.activeWindow == "user_feedback")
         {
            setStateUserThanks();
         }
         else
         {
            setStateClosed(true);
         }
      }
      
      private function onGuideSessionStarted(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionStarted");
         if(_disposed)
         {
            return;
         }
         var _loc2_:GuideSessionStartedMessageEventParser = param1.parser as GuideSessionStartedMessageEventParser;
         _sessionData.userId = _loc2_.requesterUserId;
         _sessionData.userName = _loc2_.requesterName;
         _sessionData.userFigure = _loc2_.requesterFigure;
         _sessionData.guideId = _loc2_.guideUserId;
         _sessionData.guideName = _loc2_.guideName;
         _sessionData.guideFigure = _loc2_.guideFigure;
         _lastTypingInfo = false;
         if(_sessionData.isActiveGuideSession())
         {
            setStateGuideOngoing();
         }
         else
         {
            setStateUserOngoingRequest();
         }
      }
      
      private function onGuideSessionEnded(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionEnded");
         if(_disposed)
         {
            return;
         }
         var _loc2_:GuideSessionEndedMessageEventParser = param1.parser as GuideSessionEndedMessageEventParser;
         if(_sessionData.isActiveGuideSession())
         {
            setStateGuideClosed(_loc2_.endReason);
         }
         else if(_loc2_.endReason == 0)
         {
            setStateUserGuideDisconnected();
         }
         else
         {
            setStateUserFeedback();
         }
      }
      
      private function onGuideSessionError(param1:GuideSessionErrorMessageEvent) : void
      {
         class_21.log("onGuideSessionError");
         if(_disposed)
         {
            return;
         }
         var _loc2_:GuideSessionErrorMessageEventParser = param1.getParser();
         switch(_loc2_.errorCode - 1)
         {
            case 0:
               setStateRejected();
               break;
            case 1:
            case 2:
               setStateClosedWithNotification("guide.bully.request.error.not_enough_guardians");
               break;
            default:
               setStateError();
         }
      }
      
      private function onGuideSessionMessage(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc6_:String = null;
         class_21.log("onGuideSessionMessage");
         if(_disposed || !_sessionData.isOnGoingSession() || _window == null)
         {
            return;
         }
         var _loc5_:GuideSessionMessageMessageEventParser = param1.parser as GuideSessionMessageMessageEventParser;
         var _loc3_:int = _loc5_.senderId;
         if(_loc3_ == _sessionData.guideId)
         {
            _loc4_ = _sessionData.guideName;
            _loc6_ = _sessionData.guideFigure;
         }
         else
         {
            _loc4_ = _sessionData.userName;
            _loc6_ = _sessionData.userFigure;
         }
         var _loc2_:Boolean = true;
         if(_sessionData.isActiveGuideSession() && _sessionData.guideId == _loc3_)
         {
            _loc2_ = false;
         }
         else if(!_sessionData.isActiveGuideSession() && _sessionData.userId == _loc3_)
         {
            _loc2_ = false;
         }
         addChatMessage(_loc3_,_loc4_,_loc6_,_loc5_.chatMessage,_loc2_);
      }
      
      private function onGuideSessionRequesterRoom(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionRequesterRoom");
         if(_disposed || !_sessionData.isOnGoingSession())
         {
            return;
         }
         var _loc2_:GuideSessionRequesterRoomMessageEventParser = param1.parser as GuideSessionRequesterRoomMessageEventParser;
         if(_loc2_.getRequesterRoomId() > 0)
         {
            _habboHelp.roomSessionManager.gotoRoom(_loc2_.getRequesterRoomId());
         }
         else
         {
            addChatMessage(_sessionData.guideId,_sessionData.guideName,_sessionData.guideFigure,_habboHelp.localization.getLocalization("guide.help.request.guide.ongoing.user.not.in.room.error",""),false,2);
         }
      }
      
      private function onGuideSessionInvitedToGuideRoom(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionInvitedToGuideRoom");
         if(_disposed || _window == null || !_sessionData.isOnGoingSession())
         {
            return;
         }
         var _loc2_:GuideSessionInvitedToGuideRoomMessageEventParser = param1.parser as GuideSessionInvitedToGuideRoomMessageEventParser;
         if(_sessionData.isActiveGuideSession())
         {
            if(_loc2_.getRoomId() > 0)
            {
               addSystemMessage(0,_habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.error.invite.success","","name",_sessionData.userName));
            }
            else
            {
               addSystemMessage(0,_habboHelp.localization.getLocalization("guide.help.request.guide.ongoing.error.invite.failed",""));
            }
         }
         else if(_loc2_.getRoomId() > 0)
         {
            addChatMessage(_sessionData.guideId,_sessionData.guideName,_sessionData.guideFigure,_habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.visit.guide.request.message","","name",_sessionData.guideName,"roomname",_loc2_.getRoomName()),true,1,_loc2_.getRoomId());
         }
      }
      
      private function onGuideSessionPartnerIsTyping(param1:IMessageEvent) : void
      {
         class_21.log("onGuideSessionPartnerIsTyping");
         var _loc2_:GuideSessionPartnerIsTypingMessageEventParser = GuideSessionPartnerIsTypingMessageEvent(param1).getParser();
         displayPartnerIsTypingMessage(_loc2_.isTyping);
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:PerkAllowancesMessageEventParser = null;
         if(_sessionData.activeWindow == "guide_tool")
         {
            _loc2_ = param1.getParser();
            if(!_loc2_.isPerkAllowed("USE_GUIDE_TOOL"))
            {
               if(_onDuty)
               {
                  setOnDuty(false);
                  _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false,false,false,false));
               }
               setStateClosed(false);
            }
         }
      }
      
      private function onChatReviewSessionOfferedToGuide(param1:ChatReviewSessionOfferedToGuideMessageEvent) : void
      {
         setStateGuardianChatReviewAccept(param1.getParser().acceptanceTimeout);
      }
      
      private function onChatReviewSessionStarted(param1:ChatReviewSessionStartedMessageEvent) : void
      {
         var _loc2_:ChatReviewSessionStartedMessageEventParser = param1.getParser();
         setStateGuardianChatReviewVote(_loc2_.votingTimeout,_loc2_.chatRecord);
      }
      
      private function onChatReviewSessionVotingStatus(param1:ChatReviewSessionVotingStatusMessageEvent) : void
      {
         if(_sessionData.activeWindow != "guardian_chat_review_wait_for_results")
         {
            return;
         }
         showStatus(_window.findChildByName("results") as IItemListWindow,param1.getParser().status);
      }
      
      private function onChatReviewSessionResults(param1:ChatReviewSessionResultsMessageEvent) : void
      {
         var _loc2_:ChatReviewSessionResultsMessageEventParser = param1.getParser();
         setStateGuardianChatReviewResults(_loc2_.winningVoteCode,_loc2_.ownVoteCode,_loc2_.finalStatus);
      }
      
      private function onChatReviewSessionDetached(param1:IMessageEvent) : void
      {
         setStateClosed(true);
      }
      
      private function setStateGuideTool() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc1_:class_1812 = null;
         if(_sessionData.isActiveSession())
         {
            class_21.log("Trying to set state to guide tool, but an active session exists");
            return;
         }
         _sessionData.activeWindow = "guide_tool";
         openWindow(onGuideToolEvent,true);
         setOnDutyStatus(_onDuty);
         _window.procedure = onGuideToolEvent;
         setCheckBoxValue("handle_guardian_tickets",var_1301);
         setCheckBoxValue("handle_helper_tickets",var_1343);
         setCheckBoxValue("handle_guide_tickets",var_1299);
         if(!_habboHelp.sessionDataManager.isPerkAllowed("JUDGE_CHAT_REVIEWS"))
         {
            _loc2_ = IItemListWindow(_window.findChildByName("list"));
            _loc1_ = _loc2_.getListItemByName("handle_selection_container") as class_1812;
            _loc1_.findChildByName("handle_guardian_tickets").dispose();
            _loc1_.findChildByName("selection_separator").y = _loc1_.findChildByName("selection_separator").y - 17;
            _loc1_.height -= 17;
         }
      }
      
      private function onGuideToolEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "guide_tool")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               if(param1.type == "WME_CLICK")
               {
                  setStateClosed(false);
               }
               break;
            case "helper_group_link":
               if(param1.type == "WME_CLICK")
               {
                  var _loc3_:int = _habboHelp.getInteger("guide.help.alpha.groupid",0);
               }
               break;
            case "guide_forum_link":
               if(param1.type == "WME_CLICK")
               {
                  _loc3_ = _habboHelp.getInteger("guide.help.alpha.groupid",0);
               }
               break;
            case "guide_tool_duty":
               switch(param1.type)
               {
                  case "WE_SELECTED":
                     setOnDutyStatus(true);
                     var_1343 = (_window.findChildByName("handle_helper_tickets") as class_1885).isSelected;
                     var_1301 = _window.findChildByName("handle_guardian_tickets") != null && Boolean((_window.findChildByName("handle_guardian_tickets") as class_1885).isSelected);
                     var_1299 = (_window.findChildByName("handle_guide_tickets") as class_1885).isSelected;
                     if(!var_1343 && !var_1301 && !var_1299)
                     {
                        _habboHelp.windowManager.simpleAlert("${guide.help.guide.tool.noqueueselected.caption}","${guide.help.guide.tool.noqueueselected.subtitle}","${guide.help.guide.tool.noqueueselected.message}");
                        setOnDutyStatus(false);
                        return;
                     }
                     _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(true,var_1299,var_1343,var_1301));
                     _habboHelp.trackGoogle("guideHelp",_window.name + "_onDuty");
                     break;
                  case "WE_UNSELECTED":
                     setOnDutyStatus(false);
                     _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false,false,false,false));
                     _habboHelp.trackGoogle("guideHelp",_window.name + "_offDuty");
               }
               break;
            case "guide_tool_talent":
               if(param1.type == "WME_CLICK")
               {
                  if(_habboHelp.getBoolean("talent.track.enabled"))
                  {
                     _habboHelp.tracking.trackTalentTrackOpen("helper","guidetool");
                     _habboHelp.sendMessage(new GetTalentTrackMessageComposer("helper"));
                     _habboHelp.trackGoogle("guideHelp",_window.name + "_talent");
                  }
               }
         }
      }
      
      private function setStateGuideAccept(param1:int, param2:String, param3:int) : void
      {
         var _loc9_:class_1741 = null;
         var _loc5_:ITextWindow = null;
         var _loc7_:IItemListWindow = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(!_onDuty || _sessionData.isActiveSession())
         {
            class_21.log("Trying to set state to guide accept, but not on duty or active session exists");
            return;
         }
         _sessionData.activeWindow = "guide_accept";
         _sessionData.role = 1;
         _sessionData.requestDescription = param2;
         _sessionData.requestType = param1;
         openWindow(onGuideAcceptEvent,false);
         _habboHelp.soundManager.playSound("HBST_guide_request");
         if(param1 == 2 || param1 == 0)
         {
            _window.findChildByName("frank_greeting").visible = true;
            _window.findChildByName("request_title").caption = "${guide.help.request.guide.accept.tour_request.title}";
            _window.findChildByName("request_type").dispose();
            _loc9_ = _window.findChildByName("request_description_wrapper");
            _loc5_ = _window.findChildByName("request_description") as ITextWindow;
            _loc7_ = _window.findChildByName("itemlist") as IItemListWindow;
            _loc7_.addListItemAt(_loc5_,_loc7_.getListItemIndex(_loc9_));
            _loc7_.removeListItem(_loc9_);
            _loc5_.x = _window.findChildByName("request_title").x;
            _loc5_.margins.top = 10;
            _loc5_.caption = param2;
            _loc6_ = int(_loc7_.height);
            _loc4_ = int(_window.findChildByName("skip_link").bottom);
            _loc7_.height = _loc4_;
            _window.findChildByName("border").height = _window.findChildByName("border").height + (_loc4_ - _loc6_);
            _window.height += _loc4_ - _loc6_ + 40;
         }
         else
         {
            _window.findChildByName("request_type").caption = getRequestTypeCaption(param1);
            _window.findChildByName("request_description").caption = param2;
         }
         var _loc8_:class_2728 = class_2728(class_2010(_window.findChildByName("countdown")).widget);
         _loc8_.seconds = param3;
         _loc8_.running = true;
      }
      
      private function onGuideAcceptEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "guide_accept" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "accept_button":
               _habboHelp.sendMessage(new GuideSessionGuideDecidesMessageComposer(true));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickAccept");
               closeWindow();
               break;
            case "skip_link":
               _habboHelp.sendMessage(new GuideSessionGuideDecidesMessageComposer(false));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickSkip");
               closeWindow();
         }
      }
      
      private function setStateGuideOngoing() : void
      {
         var inputWidget:IIlluminaInputWidget;
         var title:String;
         var summary:String;
         if(!_onDuty || !_sessionData.isActiveGuideSession())
         {
            class_21.log("Trying to set state to guide ongoing, but not on duty or no active guide session");
            return;
         }
         _sessionData.activeWindow = "guide_ongoing";
         openWindow(onGuideOngoingEvent,false);
         addChatMessage(_sessionData.userId,_sessionData.userName,_sessionData.userFigure,_sessionData.requestDescription,true,2);
         _window.caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.title","","name",_sessionData.userName);
         inputWidget = IIlluminaInputWidget(class_2010(_window.findChildByName("input_widget")).widget);
         inputWidget.submitHandler = this;
         inputWidget.emptyMessage = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.input.empty","","name",_sessionData.userName);
         inputWidget.maxChars = _habboHelp.getInteger("guide.help.request.max.chat.message.length",150);
         if(_sessionData.requestType == 2 || _sessionData.requestType == 0)
         {
            title = "${guide.help.request.join.room.title}";
            summary = _habboHelp.localization.getLocalizationWithParams("guide.help.request.join.room.summary","","name",_sessionData.userName);
            _habboHelp.windowManager.confirm(title,summary,0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  _habboHelp.sendMessage(new GuideSessionGetRequesterRoomMessageComposer());
               }
            });
         }
      }
      
      private function onGuideOngoingEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "guide_ongoing" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "visit_button":
               _habboHelp.sendMessage(new GuideSessionGetRequesterRoomMessageComposer());
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickVisit");
               break;
            case "invite_button":
               _habboHelp.sendMessage(new GuideSessionInviteRequesterMessageComposer());
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickInvite");
               break;
            case "report_link":
               tryOpeningReportWindow();
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickReport");
               break;
            case "close_link":
               _habboHelp.sendMessage(new GuideSessionResolvedMessageComposer());
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickClose");
               closeWindow();
         }
      }
      
      private function setStateGuideClosed(param1:int) : void
      {
         if(!_onDuty || !_sessionData.isActiveGuideSession())
         {
            class_21.log("Trying to set state to guide ongoing, but not on duty or no active guide session");
            return;
         }
         _sessionData.activeWindow = "guide_closed";
         openWindow(onGuideClosedEvent,true);
         if(param1 == 0 || param1 == 1)
         {
            _window.findChildByName("close_reason").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.closed.reason.other","","name",_sessionData.userName);
         }
         else
         {
            _window.findChildByName("close_reason").caption = _habboHelp.localization.getLocalization("guide.help.request.guide.closed.reason.you","");
         }
         _window.findChildByName("report_link").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.closed.report.link","","name",_sessionData.userName);
         class_2478(class_2010(_window.findChildByName("requester_avatar")).widget).figure = _sessionData.userFigure;
      }
      
      private function onGuideClosedEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "guide_closed" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "close_button":
            case "header_button_close":
               _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(true));
               closeWindow();
               break;
            case "report_link":
               tryOpeningReportWindow();
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickReport");
         }
      }
      
      private function setStateUserCreateRequest(param1:uint, param2:String = null) : void
      {
         if(_sessionData.isActiveSession())
         {
            class_21.log("Trying to set state to user create, but active session exists");
            return;
         }
         _sessionData.role = 2;
         _sessionData.activeWindow = "user_create";
         _sessionData.requestType = param1;
         openWindow(onUserCreateEvent,true);
         var _loc3_:IIlluminaInputWidget = IIlluminaInputWidget(class_2010(_window.findChildByName("input_widget")).widget);
         _loc3_.maxChars = _habboHelp.getInteger("guide.help.request.max.description.length",255);
         if(param2)
         {
            _loc3_.message = param2;
         }
      }
      
      private function onUserCreateEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:String = null;
         if(disposed || _window == null || _window.name != "user_create" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "create_button":
               _loc3_ = StringUtil.trim(IIlluminaInputWidget(class_2010(_window.findChildByName("input_widget")).widget).message);
               if(_loc3_.length < _habboHelp.getInteger("guide.help.request.min.description.length",15))
               {
                  _window.findChildByName("create_error").visible = true;
                  IItemListWindow(_window.findChildByName("list")).arrangeListItems();
                  break;
               }
               _habboHelp.sendMessage(new GuideSessionCreateMessageComposer(_sessionData.requestType,_loc3_));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickCreate");
               closeWindow();
               break;
            case "header_button_close":
            case "cancel_link":
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickCancel");
               setStateClosed(true);
         }
      }
      
      private function setStateUserPendingRequest(param1:int, param2:String, param3:int) : void
      {
         if(!_sessionData.isActiveUserSession())
         {
            class_21.log("Trying to set state to user pending request, but no active user session");
            return;
         }
         _sessionData.activeWindow = "user_pending";
         _sessionData.requestType = param1;
         _sessionData.requestDescription = param2;
         openWindow(onUserPendingEvent,false);
         _window.findChildByName("request_type").caption = getRequestTypeCaption(param1);
         _window.findChildByName("request_description").caption = param2;
         _window.findChildByName("waiting_time").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.pending.info.waiting","","waitingtime",FriendlyTime.getFriendlyTime(_habboHelp.localization,param3));
      }
      
      private function onUserPendingEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "user_pending" || param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("cancel_button" === _loc3_)
         {
            _habboHelp.sendMessage(new GuideSessionRequesterCancelsMessageComposer());
            _habboHelp.trackGoogle("guideHelp",_window.name + "_clickCancel");
            closeWindow();
         }
      }
      
      private function setStateUserOngoingRequest() : void
      {
         if(!_sessionData.isActiveUserSession())
         {
            class_21.log("Trying to set state to user ongoing request, but no active user session");
            return;
         }
         _sessionData.activeWindow = "user_ongoing";
         openWindow(onUserOngoingEvent,false);
         addSystemMessage(1,_habboHelp.localization.getLocalization("guide.help.requester.disclaimer"));
         if(_sessionData.requestType == 0 || _sessionData.requestType == 2)
         {
            addSystemMessage(2,_habboHelp.localization.getLocalization("guide.help.request.tour.reminder"));
         }
         else
         {
            addChatMessage(_sessionData.userId,_sessionData.userName,_sessionData.userFigure,_sessionData.requestDescription,false,2);
         }
         _window.caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.title","","name",_sessionData.guideName);
         _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
         var _loc1_:IIlluminaInputWidget = IIlluminaInputWidget(class_2010(_window.findChildByName("input_widget")).widget);
         _loc1_.submitHandler = this;
         _loc1_.emptyMessage = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.input.help","","name",_sessionData.guideName);
         _loc1_.maxChars = _habboHelp.getInteger("guide.help.request.max.chat.message.length",150);
      }
      
      private function onUserOngoingEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "user_ongoing" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "guide_name_link":
               _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickProfile");
               break;
            case "report_guide_link":
               tryOpeningReportWindow();
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickReport");
               break;
            case "close_link":
               _habboHelp.sendMessage(new GuideSessionResolvedMessageComposer());
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickClose");
               closeWindow();
         }
      }
      
      private function setStateUserGuideDisconnected() : void
      {
         if(!_sessionData.isActiveUserSession())
         {
            class_21.log("Trying to set state to user guide disconnected, but no active user session");
            return;
         }
         _sessionData.activeWindow = "user_guide_disconnected";
         openWindow(onUserGuideDisconnected,true);
         _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
      }
      
      private function onUserGuideDisconnected(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "user_guide_disconnected" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
               closeWindow();
               break;
            case "guide_name_link":
               _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickProfile");
               break;
            case "report_guide_link":
               tryOpeningReportWindow();
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickReport");
               break;
            case "resubmit_button":
               var_4929 = true;
               _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickResubmit");
               closeWindow();
         }
      }
      
      private function setStateUserFeedback() : void
      {
         if(!_sessionData.isActiveUserSession())
         {
            class_21.log("Trying to set state to user feedback, but no active user session");
            return;
         }
         _sessionData.activeWindow = "user_feedback";
         openWindow(onUserFeedbackEvent,false);
         _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
      }
      
      private function onUserFeedbackEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "user_feedback" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "guide_name_link":
               _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickProfile");
               break;
            case "report_guide_link":
               tryOpeningReportWindow();
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickReport");
               break;
            case "positive_button":
               _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(true));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickPositiveFeedback");
               closeWindow();
               break;
            case "negative_button":
               _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
               _habboHelp.trackGoogle("guideHelp",_window.name + "_clickNegativeFeedback");
               closeWindow();
         }
      }
      
      private function setStateUserThanks() : void
      {
         if(!_sessionData.isActiveUserSession())
         {
            class_21.log("Trying to set state to user thanks, but no active user session");
            return;
         }
         _sessionData.activeWindow = "user_thanks";
         openWindow(onUserThanksEvent,true);
      }
      
      private function onUserThanksEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "user_thanks" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               setStateClosed(false);
         }
      }
      
      private function setStateGuardianChatReviewAccept(param1:int) : void
      {
         _sessionData.activeWindow = "guardian_chat_review_accept";
         openWindow(onGuardianChatReviewAcceptEvent,false);
         _habboHelp.soundManager.playSound("HBST_guide_request");
         var _loc2_:class_2728 = class_2010(_window.findChildByName("countdown")).widget as class_2728;
         _loc2_.seconds = param1;
         _loc2_.running = true;
      }
      
      private function onGuardianChatReviewAcceptEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "skip_link":
               _habboHelp.sendMessage(new ChatReviewGuideDecidesOnOfferMessageComposer(false));
               setStateClosed(true);
               break;
            case "accept_button":
               _habboHelp.sendMessage(new ChatReviewGuideDecidesOnOfferMessageComposer(true));
               setStateGuardianChatReviewWaitForOtherVoters();
         }
      }
      
      private function setStateGuardianChatReviewWaitForOtherVoters() : void
      {
         _sessionData.activeWindow = "guardian_chat_review_wait_for_voters";
         openWindow(onGuardianChatReviewWaitForOtherVotersEvent,false);
         startWaitingAnimation(_window.findChildByName("waiting_animation") as IStaticBitmapWrapperWindow,"help_chat_review_progress_big",4);
      }
      
      private function onGuardianChatReviewWaitForOtherVotersEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("close_link" === _loc3_)
         {
            _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
            setStateClosed(true);
         }
      }
      
      private function setStateGuardianChatReviewVote(param1:int, param2:String) : void
      {
         var _loc18_:Date = null;
         var _loc15_:Array = null;
         var _loc12_:int = 0;
         var _loc10_:String = null;
         var _loc5_:* = false;
         var _loc11_:String = null;
         _sessionData.activeWindow = "guardian_chat_review_vote";
         openWindow(onGuardianChatReviewVoteEvent,false);
         var _loc7_:class_2728 = class_2010(_window.findChildByName("countdown")).widget as class_2728;
         _loc7_.seconds = param1;
         _loc7_.running = true;
         var _loc3_:Array = param2.substr(0,param2.indexOf(";")).match(/\d+/g);
         if(_loc3_.length > 5)
         {
            _loc18_ = new Date(_loc3_[0],int(_loc3_[1]) - 1,_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5]);
         }
         else
         {
            _loc18_ = new Date();
         }
         var _loc16_:Number = (new Date().getTime() - _loc18_.getTime()) / 1000;
         _window.findChildByName("incident_time").caption = "(" + FriendlyTime.getFriendlyTime(_habboHelp.localization,_loc16_,".ago") + ")";
         var _loc4_:IItemListWindow = _window.findChildByName("chatlog") as IItemListWindow;
         var _loc8_:class_1741 = _window.findChildByName("reported_user_template");
         var _loc6_:class_1741 = _window.findChildByName("other_user_template");
         var _loc9_:class_1741 = _window.findChildByName("separator_template");
         _loc4_.removeListItems();
         var _loc14_:int = -1;
         var _loc13_:class_1812 = null;
         for each(var _loc17_ in param2.split("\r"))
         {
            if(_loc17_ != "")
            {
               _loc15_ = _loc17_.split(";",3);
               _loc12_ = 1;
               if(_loc15_.length >= 3)
               {
                  _loc12_ = int(_loc15_[1]);
                  _loc10_ = String(_loc15_[2]).replace("<","&lt;").replace(">","&gt;");
                  if(_loc12_ == _loc14_ && _loc13_ != null)
                  {
                     _loc13_.findChildByName("message").caption = _loc13_.findChildByName("message").caption + ("\n" + _loc10_);
                  }
                  else
                  {
                     _loc5_ = _loc12_ == 0;
                     _loc13_ = (_loc5_ ? _loc8_.clone() : _loc6_.clone()) as class_1812;
                     _loc11_ = _loc5_ ? _habboHelp.localization.getLocalization("guide.bully.request.guide.vote.perpetrator","") : _habboHelp.localization.getLocalizationWithParams("guide.bully.request.guide.vote.anonymous","%ID%","id",_loc12_.toString());
                     _loc13_.findChildByName("message").caption = "<b>" + _loc11_ + ":</b> " + _loc10_;
                     _loc4_.addListItem(_loc13_);
                     _loc14_ = _loc12_;
                  }
               }
            }
         }
      }
      
      private function onGuardianChatReviewVoteEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc5_:String = null;
         var _loc6_:IRegionWindow = null;
         var _loc3_:String = null;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         if(disposed || _window == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "close_link":
                  _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
                  setStateClosed(true);
                  break;
               case "vote_ok":
                  _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(0));
                  setStateGuardianChatReviewWaitForResults(0);
                  break;
               case "vote_bad":
                  _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(1));
                  setStateGuardianChatReviewWaitForResults(1);
                  break;
               case "vote_very_bad":
                  _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(2));
                  setStateGuardianChatReviewWaitForResults(2);
            }
         }
         else if(param2.type == 5 && param2.name.substr(0,5) == "vote_")
         {
            _loc5_ = param2.name.substr(5);
            _loc6_ = param2 as IRegionWindow;
            _loc3_ = "help_chat_review_vote_" + _loc5_;
            _loc4_ = _loc6_.getChildAt(0) as IStaticBitmapWrapperWindow;
            switch(param1.type)
            {
               case "WME_OVER":
                  _loc4_.id |= 1;
                  break;
               case "WME_OUT":
                  _loc4_.id &= -2;
                  break;
               case "WME_DOWN":
                  _loc4_.id |= 2;
                  break;
               case "WME_UP":
               case "WME_UP_OUTSIDE":
                  _loc4_.id &= -3;
            }
            switch(int(_loc4_.id) - 1)
            {
               case 0:
                  _loc4_.assetUri = _loc3_ + "_over";
                  break;
               case 2:
                  _loc4_.assetUri = _loc3_ + "_down";
                  break;
               default:
                  _loc4_.assetUri = _loc3_;
            }
         }
      }
      
      private function setStateGuardianChatReviewWaitForResults(param1:int) : void
      {
         _sessionData.activeWindow = "guardian_chat_review_wait_for_results";
         openWindow(onGuardianChatReviewWaitForResultsEvent,true);
         showOwnVote(param1);
      }
      
      private function onGuardianChatReviewWaitForResultsEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
               setStateClosed(true);
         }
      }
      
      private function setStateGuardianChatReviewResults(param1:int, param2:int, param3:Array) : void
      {
         _sessionData.activeWindow = "guardian_chat_review_results";
         openWindow(onGuardianChatReviewResultsEvent,true);
         var _loc4_:int = statusFromVote(param1);
         _window.findChildByName("result_text").caption = "${guide.bully.request.guide.results.outcome." + RESULT_KEYS[_loc4_] + "}";
         IStaticBitmapWrapperWindow(_window.findChildByName("result_image")).assetUri = "help_chat_review_decision_" + STATUS_KEYS[_loc4_];
         showOwnVote(param2);
         showStatus(_window.findChildByName("results") as IItemListWindow,param3);
      }
      
      private function onGuardianChatReviewResultsEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
               setStateClosed(true);
         }
      }
      
      private function showOwnVote(param1:int) : void
      {
         var _loc2_:int = statusFromVote(param1);
         _window.findChildByName("vote_text").caption = "${guide.bully.request.guide.results.outcome." + STATUS_KEYS[_loc2_] + "}";
         IStaticBitmapWrapperWindow(_window.findChildByName("vote_image")).assetUri = "help_chat_review_decision_" + STATUS_KEYS[_loc2_];
      }
      
      private function showStatus(param1:IItemListWindow, param2:Array) : void
      {
         var _loc3_:class_1812 = null;
         var _loc6_:int = 0;
         var _loc4_:class_1812 = null;
         var _loc7_:int = 0;
         var _loc5_:IStaticBitmapWrapperWindow = null;
         if(param1.numListItems < param2.length + 1)
         {
            _loc4_ = param1.getListItemAt(0) as class_1812;
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               _loc3_ = _loc4_.clone() as class_1812;
               param1.addListItem(_loc3_);
               _loc6_++;
            }
            _loc3_.findChildByName("vote_separator").dispose();
         }
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc3_ = param1.getListItemAt(_loc6_ + 1) as class_1812;
            _loc7_ = int(param2[_loc6_]);
            _loc5_ = _loc3_.findChildByName("vote_image") as IStaticBitmapWrapperWindow;
            _loc3_.findChildByName("vote_text").caption = "${guide.bully.request.guide.results.outcome." + STATUS_KEYS[_loc7_] + "}";
            stopWaitingAnimation(_loc5_);
            switch(_loc7_)
            {
               case 0:
               case 5:
                  startWaitingAnimation(_loc5_,"help_chat_review_decision_" + STATUS_KEYS[_loc7_],2);
                  break;
               default:
                  _loc5_.assetUri = "help_chat_review_decision_" + STATUS_KEYS[_loc7_];
            }
            _loc6_++;
         }
      }
      
      private function setStateClosedWithNotification(param1:String) : void
      {
         _habboHelp.windowManager.simpleAlert("${" + param1 + ".title}","${" + param1 + ".heading}","${" + param1 + ".message}");
         setStateClosed(true);
      }
      
      private function setStateError() : void
      {
         setOnDuty(false);
         _sessionData.activeWindow = "error_window";
         openWindow(onErrorWindowEvent,true);
      }
      
      private function onErrorWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "error_window" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               setStateClosed(true);
         }
      }
      
      private function setStateRejected() : void
      {
         setOnDuty(false);
         _sessionData.activeWindow = "rejected_window";
         openWindow(onRejectedWindowEvent,true);
         if(_sessionData.requestType == 0 || _sessionData.requestType == 2)
         {
            _window.caption = "${guide.help.request.no_tour_guides.title}";
            _window.findChildByName("heading").caption = "${guide.help.request.no_tour_guides.heading}";
            _window.findChildByName("message").caption = "${guide.help.request.no_tour_guides.message}";
         }
      }
      
      private function onRejectedWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || _window.name != "rejected_window" || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               setStateClosed(true);
         }
      }
      
      private function setStateClosed(param1:Boolean) : void
      {
         resetSessionData();
         closeWindow();
         if(_onDuty && !_habboHelp.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL"))
         {
            setOnDuty(false);
         }
         if(param1 && _onDuty)
         {
            setStateGuideTool();
         }
      }
      
      private function openWindow(param1:Function, param2:Boolean) : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window != null)
         {
            closeWindow();
         }
         class_21.log("Opening window " + _sessionData.activeWindow);
         _window = _guideHelp.habboHelp.getXmlWindow(_sessionData.activeWindow) as class_1812;
         _window.position = var_1890;
         _window.procedure = param1;
         _window.findChildByName("header_button_close").visible = param2;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            class_21.log("Closing window: " + _window.name);
            var_1890.x = Math.max(0,_window.position.x);
            var_1890.y = Math.max(0,_window.position.y);
            _window.dispose();
            _window = null;
         }
      }
      
      private function tryOpeningReportWindow() : void
      {
         _habboHelp.queryForPendingCallsForHelp(2);
      }
      
      public function openReportWindow() : void
      {
         if(var_341 || _window == null)
         {
            return;
         }
         var _loc1_:class_2052 = _habboHelp.windowManager.getDesktop(0);
         var_341 = class_1812(_habboHelp.getXmlWindow("report_window"));
         var_341.procedure = onReportWindowEvent;
         var_341.x = Math.max(0,Math.min(_loc1_.width - var_341.width,_window.x + _window.width + 10));
         var_341.y = Math.max(0,_window.y);
      }
      
      private function closeReportWindow() : void
      {
         if(var_341)
         {
            var_341.dispose();
            var_341 = null;
         }
      }
      
      private function onReportWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || !var_341 || Boolean(var_341.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "cancel_link":
               _habboHelp.trackGoogle("guideHelp",var_341.name + "_clickClose");
               closeReportWindow();
               break;
            case "submit_button":
               var _loc3_:String = IIlluminaInputWidget(class_2010(var_341.findChildByName("input_widget")).widget).message;
               if(null.length == 0)
               {
                  var_341.findChildByName("report_error").visible = true;
                  IItemListWindow(var_341.findChildByName("list")).arrangeListItems();
                  break;
               }
               _habboHelp.sendMessage(new GuideSessionReportMessageComposer(null));
               _habboHelp.trackGoogle("guideHelp",var_341.name + "_clickReport");
               closeReportWindow();
               closeWindow();
               break;
            case "urgent_help_link":
         }
      }
      
      private function resetSessionData() : void
      {
         _sessionData = new GuideSessionData();
      }
      
      private function setOnDutyStatus(param1:Boolean) : void
      {
         var _loc2_:class_1885 = class_1885(_window.findChildByName("guide_tool_duty"));
         setOnDuty(param1);
         _loc2_.isSelected = param1;
         if(param1)
         {
            _loc2_.caption = _habboHelp.localization.getLocalization("guide.help.guide.tool.duty.on","");
         }
         else
         {
            _loc2_.caption = _habboHelp.localization.getLocalization("guide.help.guide.tool.duty.off","");
         }
         var _loc3_:class_1741 = _window.findChildByName("disabled_screen");
         if(_loc3_)
         {
            _loc3_.visible = param1;
         }
      }
      
      private function setCheckBoxValue(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_1885 = _window.findChildByName(param1) as class_1885;
         if(_loc3_ != null)
         {
            _loc3_.isSelected = param2;
         }
      }
      
      private function getRequestTypeCaption(param1:int) : String
      {
         if(param1 == 2)
         {
            param1 = 0;
         }
         return _habboHelp.localization.getLocalization("guide.help.request.type." + param1,"");
      }
      
      private function addChatMessage(param1:int, param2:String, param3:String, param4:String, param5:Boolean, param6:int = 0, param7:* = null) : void
      {
         var _loc8_:IIlluminaChatBubbleWidget = null;
         var _loc9_:class_1812 = null;
         var _loc10_:class_2010 = getLastChatListItem();
         if(_loc10_ != null && null != _loc10_.widget as IIlluminaChatBubbleWidget && _loc10_.name == "chat_msg_0")
         {
            _loc8_ = IIlluminaChatBubbleWidget(_loc10_.widget);
         }
         if(_loc8_ && _loc8_.userId == param1 && param6 == 0)
         {
            _loc8_.appendMessage(param4);
            addItemAndUpdateChatList(null);
         }
         else
         {
            _loc10_ = class_2010(_chatMsg.clone());
            _loc10_.name = "chat_msg_" + param6;
            _loc8_ = IIlluminaChatBubbleWidget(_loc10_.widget);
            _loc8_.figure = param3;
            _loc8_.flipped = param5;
            _loc8_.appendMessage(param4);
            _loc8_.userName = param2;
            _loc8_.userId = param1;
            switch(param6 - 1)
            {
               case 0:
                  _loc9_ = class_1812(class_1812(_loc10_.rootWindow).findChildByName("message_region"));
                  _loc9_.procedure = onChatMessageEvent;
                  _loc9_.setParamFlag(1,true);
                  _loc9_.id = param7;
                  ITextWindow(_loc9_.findChildByName("message")).underline = true;
            }
            addItemAndUpdateChatList(_loc10_);
         }
      }
      
      private function onChatMessageEvent(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         _habboHelp.navigator.goToPrivateRoom(param2.id);
      }
      
      private function addItemAndUpdateChatList(param1:class_1741) : void
      {
         var _loc2_:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
         if(param1)
         {
            _loc2_.addListItemAt(param1,_loc2_.numListItems - 1);
         }
         _loc2_.scrollV = 1;
         _loc2_.arrangeListItems();
         resetTypingTimer();
      }
      
      private function addSystemMessage(param1:int, param2:String) : void
      {
         var _loc3_:class_1812 = null;
         if(!_sessionData.isOnGoingSession() || param2 == "")
         {
            return;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = var_1901.clone() as class_1812;
               _loc3_.findChildByName("content").caption = param2;
               addItemAndUpdateChatList(_loc3_);
               break;
            case 1:
               _loc3_ = var_4513.clone() as class_1812;
               _loc3_.findChildByName("content").caption = param2;
               addItemAndUpdateChatList(_loc3_);
               break;
            default:
               if(_sessionData.isActiveUserSession())
               {
                  addChatMessage(_sessionData.userId,_sessionData.userName,_sessionData.userFigure,param2,true,2);
                  break;
               }
               addChatMessage(_sessionData.guideId,_sessionData.guideName,_sessionData.guideFigure,param2,true,2);
         }
      }
      
      private function getLastChatListItem() : class_2010
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return null;
         }
         var _loc1_:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
         if(_loc1_.numListItems > 1)
         {
            return _loc1_.getListItemAt(_loc1_.numListItems - 2) as class_2010;
         }
         return null;
      }
      
      public function onInput(param1:class_2010, param2:String) : void
      {
         if(param2.length > 0)
         {
            _habboHelp.sendMessage(new GuideSessionMessageMessageComposer(param2));
            IIlluminaInputWidget(param1.widget).message = "";
            resetTypingTimer();
         }
      }
      
      private function setOnDuty(param1:Boolean) : void
      {
         _onDuty = param1;
         _habboHelp.toolbar.onDuty = param1;
      }
      
      private function resetTypingTimer() : void
      {
         if(var_715 != null)
         {
            var_715.stop();
            var_715 = null;
         }
         if(_window == null || Boolean(_window.disposed) || _window.name != "user_ongoing" && _window.name != "guide_ongoing")
         {
            return;
         }
         var_715 = new Timer(3000);
         var_715.addEventListener("timer",onTypingTimer);
         var_715.start();
         _lastMessageTypedLength = messageLength;
         displayPartnerIsTypingMessage(false);
      }
      
      private function get messageLength() : int
      {
         if(_window == null || Boolean(_window.disposed) || _window.name != "user_ongoing" && _window.name != "guide_ongoing")
         {
            return 0;
         }
         var _loc1_:class_2010 = _window.findChildByName("input_widget") as class_2010;
         return _loc1_ != null ? IIlluminaInputWidget(_loc1_.widget).message.length : 0;
      }
      
      private function onTypingTimer(param1:TimerEvent) : void
      {
         if(_window == null || Boolean(_window.disposed) || _window.name != "user_ongoing" && _window.name != "guide_ongoing")
         {
            return;
         }
         var _loc2_:* = _lastMessageTypedLength != 0;
         if(_lastTypingInfo != _loc2_)
         {
            _habboHelp.sendMessage(new GuideSessionIsTypingMessageComposer(_loc2_));
            _lastTypingInfo = _loc2_;
         }
         _lastMessageTypedLength = 0;
      }
      
      private function displayPartnerIsTypingMessage(param1:Boolean) : void
      {
         if(_window == null || Boolean(_window.disposed) || _window.name != "user_ongoing" && _window.name != "guide_ongoing")
         {
            return;
         }
         var _loc2_:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
         _loc2_.getListItemAt(_loc2_.numListItems - 1).blend = param1 ? 1 : 0;
      }
      
      private function onWaitingAnimationTimer(param1:TimerEvent) : void
      {
         var data:AnimationData;
         var event:TimerEvent = param1;
         var_864 = var_864.filter(function(param1:AnimationData, param2:int, param3:Vector.<AnimationData>):Boolean
         {
            return param1.window != null && !param1.window.disposed;
         });
         for each(data in var_864)
         {
            setAnimationFrame(data);
         }
      }
      
      private function startWaitingAnimation(param1:IStaticBitmapWrapperWindow, param2:String, param3:int) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc4_:AnimationData = new AnimationData(param1,param2,param3);
         setAnimationFrame(_loc4_);
         var_864.push(_loc4_);
      }
      
      private function setAnimationFrame(param1:AnimationData) : void
      {
         var _loc2_:int = var_1142.currentCount % param1.frameCount;
         param1.window.assetUri = param1.asset + "_" + (String(_loc2_ + 1));
      }
      
      private function stopWaitingAnimation(param1:IStaticBitmapWrapperWindow) : void
      {
         var window:IStaticBitmapWrapperWindow = param1;
         var_864 = var_864.filter(function(param1:AnimationData, param2:int, param3:Vector.<AnimationData>):Boolean
         {
            return param1.window != window;
         });
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var_2770 = getTimer();
      }
      
      private function onIdleCheckTimer(param1:TimerEvent) : void
      {
         if(_onDuty && getTimer() - var_2770 > _habboHelp.getInteger("guidetool.idle.timeout",300) * 1000)
         {
            _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false,var_1299,var_1343,var_1301));
         }
      }
   }
}

