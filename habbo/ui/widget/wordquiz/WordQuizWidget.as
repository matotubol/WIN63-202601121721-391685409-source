package com.sulake.habbo.ui.widget.wordquiz
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.WordQuizWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class WordQuizWidget extends RoomWidgetBase
   {
      
      private static const ASSET_NAME_LIKE:String = "wordquiz_like_xml";
      
      private static const ASSET_NAME_DISLIKE:String = "wordquiz_unlike_xml";
      
      private static const SIGN_FADE_IN_TIME:int = 750;
      
      private static const SIGN_FADE_OUT_TIME:int = 750;
      
      private static const UPDATE_FREQUENCY:int = 40;
      
      public static const VALUE_KEY_DISLIKE:String = "0";
      
      public static const VALUE_KEY_LIKE:String = "1";
      
      private var var_18:WordQuizView;
      
      private var var_3471:Timer;
      
      private var var_717:Timer;
      
      private var var_366:Timer;
      
      private var var_4024:int = 0;
      
      private var _showResultTime:int;
      
      private var _countdown:int = 0;
      
      private var var_2934:int;
      
      private var var_431:Dictionary;
      
      private var var_5276:int;
      
      private var _showSignCounters:Dictionary = new Dictionary();
      
      private var _answerWindows:Vector.<class_1812> = new Vector.<class_1812>(0);
      
      private var var_2411:Vector.<class_1812> = new Vector.<class_1812>(0);
      
      private var var_2669:Vector.<class_1812> = new Vector.<class_1812>(0);
      
      private var var_2952:Boolean;
      
      public function WordQuizWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(handler,param2,param3,param4);
         var_41 = param1;
         var_18 = new WordQuizView(this);
         _showResultTime = handler.container.config.getInteger("poll.word.quiz.answer.bubble.seconds",3) * 1000;
      }
      
      override public function get mainWindow() : class_1741
      {
         return var_18 ? var_18.mainWindow : null;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.addEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.addEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.removeEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.removeEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.unregisterUpdateEvents(param1);
      }
      
      public function get handler() : WordQuizWidgetHandler
      {
         return var_41 as WordQuizWidgetHandler;
      }
      
      override public function dispose() : void
      {
         var _loc2_:class_1812 = null;
         var _loc1_:int = 0;
         if(disposed)
         {
            return;
         }
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         if(var_3471)
         {
            var_3471.reset();
            var_3471 = null;
         }
         if(var_717)
         {
            var_717.reset();
            var_717 = null;
         }
         if(var_366)
         {
            var_366.reset();
            var_366 = null;
         }
         if(windowManager)
         {
            if(_answerWindows)
            {
               _loc1_ = 0;
               while(_loc1_ < _answerWindows.length)
               {
                  _loc2_ = _answerWindows[_loc1_] as class_1812;
                  if(_loc2_)
                  {
                     windowManager.removeWindow(_loc2_.name);
                  }
                  _loc1_++;
               }
            }
            for each(_loc2_ in var_2411)
            {
               _loc2_.destroy();
            }
            var_2411.length = 0;
            for each(_loc2_ in var_2669)
            {
               _loc2_.destroy();
            }
            var_2669.length = 0;
         }
         super.dispose();
      }
      
      private function newQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var_2934 = param1.id;
         var_431 = param1.question;
         var_2952 = false;
         _showSignCounters = new Dictionary();
         showNewQuestion(var_431,param1.duration);
      }
      
      private function questionFinished(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc2_:int = 0;
         clearTimers();
         if(var_18 && var_431 && var_431.id == param1.questionId)
         {
            var_18.displayResults(param1.answerCounts);
         }
         _loc2_ = 0;
         while(_loc2_ < _answerWindows.length)
         {
            poolWindow(_answerWindows[_loc2_].name);
            _loc2_++;
         }
         _answerWindows.length = 0;
      }
      
      private function poolWindow(param1:String) : void
      {
         if(windowManager == null)
         {
            return;
         }
         windowManager.removeWindow(param1);
      }
      
      private function answeredQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc7_:class_1812 = null;
         if(var_18)
         {
            var_18.updateResults(param1.answerCounts);
         }
         var _loc8_:int = param1.userId;
         var _loc9_:String = param1.value;
         var _loc3_:Vector.<class_1812> = _loc9_ == "1" ? var_2411 : var_2669;
         var _loc4_:String = _loc9_ == "1" ? "wordquiz_like_xml" : "wordquiz_unlike_xml";
         var _loc5_:String = var_2934 + "_" + _loc8_ + "_" + _loc4_;
         if(_loc3_.length)
         {
            _loc7_ = _loc3_.pop();
         }
         else
         {
            _loc7_ = windowManager.buildFromXML(assets.getAssetByName(_loc4_).content as XML) as class_1812;
         }
         _loc7_.name = _loc5_;
         _answerWindows.push(_loc7_);
         _showSignCounters[_loc5_] = _showResultTime + 750 + 750;
         var _loc6_:Rectangle = getAvatarRect(_loc8_);
         if(_loc6_)
         {
            _loc7_.x = _loc6_.left + 20;
            _loc7_.y = _loc6_.top - 20;
         }
         if(!var_366)
         {
            var_366 = new Timer(40);
            var_366.addEventListener("timer",onLocationTimer);
            var_366.start();
         }
         var _loc2_:class_1993 = _loc7_.getChildByName("colored") as class_1993;
         if(_loc2_)
         {
            _loc2_.blend = 0;
         }
      }
      
      private function onLocationTimer(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:class_1812 = null;
         _loc3_ = 0;
         while(_loc3_ < _answerWindows.length)
         {
            _loc5_ = _answerWindows[_loc3_];
            if(_loc5_)
            {
               var _loc2_:Array = String(_answerWindows[_loc3_].name).split("_");
               if(null.length > 1)
               {
                  var _loc6_:int = int(null[1]);
                  var _loc4_:Rectangle = getAvatarRect(0);
                  if(!_loc4_)
                  {
                     poolWindow(_answerWindows[_loc3_].name);
                     return;
                  }
                  _loc5_.x = null.left + 29;
                  _loc5_.y = null.top - 11;
                  handleSignWindowVisibility(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      private function handleSignWindowVisibility(param1:class_1812) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:class_1993 = param1.getChildByName("colored") as class_1993;
         var _loc3_:IRegionWindow = param1.getChildByName("button_like") as IRegionWindow;
         if(_showSignCounters.hasOwnProperty(param1.name) && _loc2_ && _loc3_)
         {
            _loc4_ = int(_showSignCounters[param1.name]);
            _loc4_ = _loc4_ - 40;
            _showSignCounters[param1.name] = _loc4_;
            if(_loc4_ > _showResultTime + 750)
            {
               _loc5_ = 0.1875;
               _loc2_.blend += _loc5_;
               _loc3_.blend = _loc2_.blend;
            }
            else if(_loc4_ > 750)
            {
               _loc2_.blend = 1;
               _loc3_.blend = 1;
            }
            else if(_loc4_ < 750 && _loc4_ > 0)
            {
               _loc5_ = 750 / 40;
               param1.blend -= _loc5_ * 0.01;
               param1.y -= 20 + (70 - param1.blend * 120);
            }
            else if(_loc4_ < 0)
            {
               param1.y -= 20 + (70 - param1.blend * 120);
               poolWindow(param1.name);
            }
         }
      }
      
      private function getAvatarRect(param1:int) : Rectangle
      {
         if(!handler || !handler.container || !handler.container.roomSession || !handler.container.roomEngine)
         {
            return null;
         }
         var _loc3_:int = handler.container.roomSession.roomId;
         var _loc2_:class_2146 = handler.container.roomSessionManager.getSession(_loc3_).userDataManager.getUserData(param1);
         if(_loc2_)
         {
            return handler.container.roomEngine.getRoomObjectBoundingRectangle(_loc3_,_loc2_.roomObjectId,100,handler.container.getFirstCanvasId());
         }
         return null;
      }
      
      private function onCountdownDownTimer(param1:TimerEvent) : void
      {
         if(var_717 == null)
         {
            return;
         }
         _countdown = _countdown - 1;
         var_18.updateCounter(String(_countdown));
         if(_countdown == 0)
         {
            clearTimers();
            var_18.removeWindow();
         }
      }
      
      private function showNewQuestion(param1:Dictionary, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         var_18.createWindow(0,param1.content);
         var_4024 = var_4024 + 1;
         _countdown = 4;
         var_5276 = param1.id;
         if(param2 > 0)
         {
            var_717 = new Timer(1000);
            _countdown = param2 / 1000;
            var_717.addEventListener("timer",onCountdownDownTimer);
            var_717.start();
            var_366 = new Timer(40);
            var_366.addEventListener("timer",onLocationTimer);
            var_366.start();
            var_18.updateCounter(String(_countdown));
         }
      }
      
      private function clearTimers() : void
      {
         if(var_717)
         {
            var_717.reset();
            var_717 = null;
         }
         if(var_366)
         {
            var_366.reset();
            var_366 = null;
         }
      }
      
      public function sendAnswer(param1:int) : void
      {
         var_18.removeWindow();
         if(var_2952)
         {
            return;
         }
         var _loc3_:RoomWidgetPollMessage = new RoomWidgetPollMessage("RWPM_ANSWER",var_2934);
         _loc3_.questionId = var_431["id"] as int;
         var _loc2_:Array = [];
         _loc2_.push("" + param1);
         _loc3_.answers = _loc2_;
         messageListener.processWidgetMessage(_loc3_);
         var_2952 = true;
         var_18.createWindow(1);
      }
   }
}

