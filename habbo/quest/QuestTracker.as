package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_2778;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_3170;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import package_62.class_2098;
   
   public class QuestTracker implements class_13
   {
      
      private static const TRACKER_ANIMATION_STATUS_NONE:int = 0;
      
      private static const TRACKER_ANIMATION_STATUS_SLIDE_IN:int = 1;
      
      private static const TRACKER_ANIMATION_STATUS_SLIDE_OUT:int = 2;
      
      private static const TRACKER_ANIMATION_STATUS_COMPLETED_ANIMATION:int = 3;
      
      private static const TRACKER_ANIMATION_STATUS_PROGRESS_NUDGE:int = 4;
      
      private static const TRACKER_ANIMATION_STATUS_CLOSE_WAIT:int = 5;
      
      private static const TRACKER_ANIMATION_STATUS_PROMPT_ANIMATION:int = 6;
      
      private static const MAX_SUCCESS_FRAME:int = 6;
      
      private static const PROMPT_SEQUENCE_REPEATS:int = 4;
      
      private static const PROMPT_SEQUENCE_REPEATS_QUEST_OPEN:int = 2;
      
      private static const PROMPT_FRAME_LENGTH_IN_MSECS:int = 200;
      
      private static const PROMPT_DELAY_IN_MSECS:int = 10000;
      
      private static const PROMPT_DELAY_ON_QUEST_OPEN_IN_MSECS:int = 0;
      
      private static const NO_PROMPT_DELAY:int = -1;
      
      private static const PROGRESS_BAR_WIDTH:int = 162;
      
      private static const TRACKER_SLIDE_IN_SPEED:Number = 0.01;
      
      private static const TRACKER_SLIDE_OUT_SPEED:Number = 100;
      
      private static const COMPLETION_CLOSE_DELAY_IN_MSECS:int = 1000;
      
      private static const TOOLBAR_EXTENSION_ID_PREFIX:String = "quest_tracker_";
      
      private static const const_880:int = 10;
      
      private static var var_3607:int = 0;
      
      private static const NUDGE_OFFSETS:Array = [-2,-3,-2,0,2,3,2,0,2,1,0,1];
      
      private static const const_34:Array = [1,1,2,2,3,3,4,4,5,5,6,6,4];
      
      private static const PROMPT_FRAMES:Array = ["a","b","c","d"];
      
      private static const PROGRESS_BAR_LOC:Point = new Point(10,87);
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_232:class_2098;
      
      private var _window:class_1812;
      
      private var var_653:Timer;
      
      private var var_1271:ProgressBar;
      
      private var _trackerAnimationStatus:int = 0;
      
      private var var_1363:int = 0;
      
      private var var_2375:int = 0;
      
      private var _successFrame:int = -1;
      
      private var _msecsUntilPrompt:int = -1;
      
      private var _promptFrame:int = -1;
      
      private var _msecsUntilNextPromptFrame:int;
      
      private var var_2230:int;
      
      private var var_4877:Boolean;
      
      private var var_4580:Boolean;
      
      private var var_1427:Boolean = false;
      
      private var var_2460:uint = 4294967295;
      
      private var var_3210:int;
      
      public function QuestTracker(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var_3210 = var_3607;
         var_3607 += 1;
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.toolbar.extensionView.detachExtension("quest_tracker_" + var_3210);
         }
         _questEngine = null;
         var_232 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_653)
         {
            var_653.stop();
            var_653 = null;
         }
         if(var_1271)
         {
            var_1271.dispose();
            var_1271 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuestCompleted(param1:class_2098, param2:Boolean) : void
      {
         if(_window)
         {
            clearPrompt();
            var_232 = param1;
            var_1363 = 0;
            refreshTrackerDetails();
            _successFrame = 0;
            _trackerAnimationStatus = 3;
            var_4580 = !param2;
         }
      }
      
      public function onQuestCancelled() : void
      {
         var_232 = null;
         if(_window)
         {
            clearPrompt();
            var_1271.refresh(0,100,-1,0);
            _trackerAnimationStatus = 2;
         }
      }
      
      public function startDefaultCampaign(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = _questEngine.getInteger("new.identity",0) > 0;
         if(!_loc3_)
         {
            return;
         }
         if(var_653 == null && _loc3_ && param1 != "")
         {
            _loc2_ = _questEngine.getInteger("questing.startQuestDelayInSeconds",30);
            var_653 = new Timer(_loc2_ * 1000,1);
            var_653.addEventListener("timer",onStartQuestTimer);
            var_653.start();
            class_21.log("Initialized start quest timer with period: " + _loc2_);
         }
      }
      
      public function onRoomExit() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.findChildByName("more_info_txt").visible = false;
            _window.findChildByName("more_info_region").visible = false;
         }
      }
      
      public function onQuest(param1:class_2098) : void
      {
         if(var_653 != null)
         {
            var_653.stop();
         }
         if(var_2460 != 4294967295)
         {
            clearTimeout(var_2460);
            var_2460 = 4294967295;
         }
         var _loc2_:Boolean = _window && _window.visible;
         if(param1.waitPeriodSeconds > 0)
         {
            if(_loc2_)
            {
               setWindowVisible(false);
            }
            return;
         }
         var_232 = param1;
         prepareTrackerWindow();
         refreshTrackerDetails();
         refreshPromptFrames();
         setWindowVisible(true);
         hideSuccessFrames();
         if(_loc2_)
         {
            if(this._trackerAnimationStatus == 2)
            {
               this._trackerAnimationStatus = 1;
            }
            setupPrompt(_msecsUntilPrompt,4,false);
         }
         else
         {
            this._window.x = getOutScreenLocationX();
            this._trackerAnimationStatus = 1;
            setupPrompt(0,2,false);
         }
      }
      
      private function refreshPromptFrames() : void
      {
         var _loc1_:int = 0;
         if(!_questEngine.isQuestWithPrompts(var_232))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < PROMPT_FRAMES.length)
         {
            _questEngine.setupPromptFrameImage(_window,var_232,PROMPT_FRAMES[_loc1_]);
            _loc1_++;
         }
      }
      
      private function prepareTrackerWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_1812(_questEngine.getXmlWindow("QuestTracker"));
         _window.findChildByName("more_info_region").procedure = onMoreInfo;
         hideSuccessFrames();
         var_1271 = new ProgressBar(_questEngine,class_1812(_window.findChildByName("content_cont")),162,"quests.tracker.progress",false,PROGRESS_BAR_LOC);
      }
      
      private function hideSuccessFrames() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            getSuccessFrame(_loc1_).visible = false;
            _loc1_++;
         }
      }
      
      private function hidePromptFrames() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < PROMPT_FRAMES.length)
         {
            getPromptFrame(PROMPT_FRAMES[_loc1_]).visible = false;
            _loc1_++;
         }
      }
      
      private function getSuccessFrame(param1:int) : class_1741
      {
         return _window.findChildByName("success_pic_" + param1);
      }
      
      private function getPromptFrame(param1:String) : class_1741
      {
         return _window.findChildByName("prompt_pic_" + param1);
      }
      
      private function refreshTrackerDetails() : void
      {
         _window.findChildByName("quest_header_txt").caption = _questEngine.localization.getLocalizationWithParams("quests.tracker.caption","","quest_name",_questEngine.getQuestName(var_232));
         _window.findChildByName("desc_txt").caption = _questEngine.getQuestDesc(var_232);
         _window.findChildByName("more_info_txt").visible = _questEngine.currentlyInRoom;
         _window.findChildByName("more_info_region").visible = _questEngine.currentlyInRoom;
         var _loc1_:int = Math.ceil(100 * var_232.completedSteps / var_232.totalSteps);
         var_1271.refresh(_loc1_,100,var_232.id,0);
         _questEngine.setupQuestImage(_window,var_232);
      }
      
      private function onMoreInfo(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.questController.questDetails.showDetails(var_232);
         }
      }
      
      public function forceWindowCloseAfterAnimationsFinished() : void
      {
         if(_trackerAnimationStatus == 0)
         {
            setWindowVisible(false);
            var_1427 = false;
         }
         else
         {
            var_1427 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_window == null)
         {
            return;
         }
         var_1271.updateView(param1);
         switch(_trackerAnimationStatus)
         {
            case 0:
               if(_msecsUntilPrompt != -1)
               {
                  _msecsUntilPrompt -= param1;
                  if(_msecsUntilPrompt < 0)
                  {
                     _msecsUntilPrompt = -1;
                     if(var_232 != null && _questEngine.isQuestWithPrompts(var_232))
                     {
                        if(var_4877)
                        {
                           startNudge();
                           break;
                        }
                        _trackerAnimationStatus = 6;
                        _promptFrame = 0;
                        _msecsUntilNextPromptFrame = 200;
                     }
                  }
               }
               break;
            case 1:
               _loc4_ = getDefaultLocationX();
               _loc2_ = _window.x - _loc4_;
               if(_loc2_ > 0)
               {
                  _loc3_ = Math.max(1,Math.round(_loc2_ * param1 * 0.01));
                  _window.x -= _loc3_;
                  break;
               }
               _trackerAnimationStatus = 0;
               _window.x = _loc4_;
               break;
            case 2:
               _loc4_ = getOutScreenLocationX();
               _loc2_ = _window.width - _window.x;
               if(_loc2_ > 0)
               {
                  _loc3_ = Math.max(1,Math.round(param1 * 100 / _loc2_));
                  _window.x += _loc3_;
                  break;
               }
               _trackerAnimationStatus = 0;
               _window.x = _loc4_;
               setWindowVisible(false);
               break;
            case 3:
               hideSuccessFrames();
               getSuccessFrame(const_34[_successFrame]).visible = true;
               _successFrame = _successFrame + 1;
               if(_successFrame >= const_34.length)
               {
                  _trackerAnimationStatus = 5;
                  var_2375 = 1000;
               }
               break;
            case 4:
               if(var_1363 >= NUDGE_OFFSETS.length - 1)
               {
                  _window.x = getDefaultLocationX();
                  _trackerAnimationStatus = 0;
                  setupPrompt(10000,2,false);
                  break;
               }
               _window.x = getDefaultLocationX() + NUDGE_OFFSETS[var_1363];
               var_1363 = var_1363 + 1;
               break;
            case 5:
               var_2375 -= param1;
               if(var_2375 < 0)
               {
                  _trackerAnimationStatus = 0;
                  if(var_4580 && !var_1427)
                  {
                     var_2460 = setTimeout(onNewQuestNotReceived,600);
                     _questEngine.send(new class_2778());
                     break;
                  }
                  setWindowVisible(false);
                  var_1427 = false;
               }
               break;
            case 6:
               setQuestImageVisible(false);
               hidePromptFrames();
               _msecsUntilNextPromptFrame -= param1;
               getPromptFrame(PROMPT_FRAMES[_promptFrame]).visible = true;
               if(_msecsUntilNextPromptFrame < 0)
               {
                  _msecsUntilNextPromptFrame = 200;
                  _promptFrame = _promptFrame + 1;
                  if(_promptFrame >= PROMPT_FRAMES.length)
                  {
                     _promptFrame = 0;
                     var_2230 = var_2230 - 1;
                     if(var_2230 < 1)
                     {
                        setupPrompt(10000,2,true);
                        _trackerAnimationStatus = 0;
                     }
                  }
               }
         }
      }
      
      private function onNewQuestNotReceived() : void
      {
         setWindowVisible(false);
         var_1427 = false;
      }
      
      private function getDefaultLocationX() : int
      {
         return 0;
      }
      
      private function getOutScreenLocationX() : int
      {
         return _window.width + 10;
      }
      
      private function onStartQuestTimer(param1:TimerEvent) : void
      {
         if(this.hasBlockingWindow())
         {
            class_21.log("Quest start blocked. Waiting some more");
            var_653.reset();
            var_653.start();
         }
         else
         {
            _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
            _questEngine.send(new class_3170(_questEngine.questController.getDefaultCampaign()));
         }
      }
      
      private function hasBlockingWindow() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:class_2052 = null;
         _loc2_ = 0;
         while(_loc2_ <= 2)
         {
            _loc1_ = _questEngine.windowManager.getDesktop(_loc2_);
            if(_loc1_ != null && hasBlockingWindowInLayer(_loc1_))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function hasBlockingWindowInLayer(param1:class_1812) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_1741 = null;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            if(_loc2_ != null && _loc2_.visible)
            {
               if(_loc2_ as class_2250 != null)
               {
                  if(_loc2_.name != "mod_start_panel" && _loc2_.name != "_frame")
                  {
                     return true;
                  }
               }
               else if(_loc2_.name == "welcome_screen")
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      private function setQuestImageVisible(param1:Boolean) : void
      {
         _window.findChildByName("quest_pic_bitmap").visible = param1;
      }
      
      private function clearPrompt() : void
      {
         setupPrompt(-1,0,false);
      }
      
      private function setupPrompt(param1:int, param2:int, param3:Boolean) : void
      {
         setQuestImageVisible(true);
         hidePromptFrames();
         _msecsUntilPrompt = param1;
         var_2230 = param2;
         var_4877 = param3;
      }
      
      private function startNudge() : void
      {
         var_1363 = 0;
         _trackerAnimationStatus = 4;
      }
      
      private function setWindowVisible(param1:Boolean) : void
      {
         _window.visible = param1;
         if(!param1)
         {
            _questEngine.toolbar.extensionView.detachExtension("quest_tracker_" + var_3210);
         }
         else
         {
            _questEngine.toolbar.extensionView.attachExtension("quest_tracker_" + var_3210,_window);
         }
      }
      
      public function get campaignChainCode() : String
      {
         if(var_232 == null)
         {
            return null;
         }
         return var_232.campaignChainCode;
      }
      
      public function get canBeDisposed() : Boolean
      {
         if(var_232 == null)
         {
            return true;
         }
         if(_window && !_window.visible && _trackerAnimationStatus == 0)
         {
            return true;
         }
         return false;
      }
   }
}

