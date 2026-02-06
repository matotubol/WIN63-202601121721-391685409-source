package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.communication.messages.parser.poll.class_3757;
   import com.sulake.habbo.communication.messages.parser.poll.class_3851;
   
   public class PollContentDialog implements class_3726
   {
      
      private var var_197:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var _window:class_2250;
      
      private var var_16:PollWidget;
      
      private var var_512:class_2250;
      
      private var var_4909:Boolean = false;
      
      private var var_1237:Array;
      
      private var var_431:int = -1;
      
      private var var_2424:int = 0;
      
      private var var_2606:int = -1;
      
      private var var_3036:Boolean = false;
      
      private var var_1508:int = 0;
      
      private var var_775:class_3757 = null;
      
      public function PollContentDialog(param1:int, param2:String, param3:Array, param4:PollWidget, param5:Boolean)
      {
         super();
         var_197 = param1;
         var_1237 = param3;
         var_16 = param4;
         var_3036 = param5;
         answerableQuestionCount();
         var _loc10_:XmlAsset = var_16.assets.getAssetByName("poll_question") as XmlAsset;
         if(_loc10_ != null)
         {
            _window = var_16.windowManager.buildFromXML(_loc10_.content as XML) as class_2250;
            var _loc8_:ITextWindow = _window.findChildByName("poll_question_headline") as ITextWindow;
            if(_loc8_)
            {
               null.text = param2;
            }
            _window.center();
            var _loc7_:class_1741 = _window.findChildByName("header_button_close");
            if(_loc7_ != null)
            {
               null.addEventListener("WME_CLICK",onClose);
            }
            var _loc9_:class_1741 = _window.findChildByName("poll_question_button_ok");
            if(_loc9_ != null)
            {
               null.addEventListener("WME_CLICK",onOk);
            }
            var _loc6_:class_1741 = _window.findChildByName("poll_question_cancel");
            if(_loc6_ != null)
            {
               null.addEventListener("WME_CLICK",onCancel);
            }
         }
      }
      
      public function start() : void
      {
         if(!var_4909)
         {
            var_4909 = true;
            nextQuestion();
         }
      }
      
      private function onClose(param1:class_1758) : void
      {
         showCancelConfirm();
      }
      
      private function onOk(param1:class_1758) : void
      {
         answerPollQuestion();
      }
      
      private function onCancel(param1:class_1758) : void
      {
         showCancelConfirm();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_512)
         {
            var_512.dispose();
            var_512 = null;
         }
         var_16 = null;
         var_1237 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function nextQuestion() : void
      {
         var_775 = getNextQuestion();
         if(var_775)
         {
            if(_window != null)
            {
               var _loc5_:ITextWindow = _window.findChildByName("poll_question_text") as ITextWindow;
               if(_loc5_ != null)
               {
                  null.text = var_775.questionText;
               }
               _loc5_ = _window.findChildByName("poll_question_number") as ITextWindow;
               if(_loc5_ != null)
               {
                  null.text = "${poll_question_number}";
                  var _loc2_:String = null.text;
                  _loc2_ = null.replace("%number%",var_431 + 1);
                  _loc2_ = null.replace("%count%",var_2424);
                  null.text = null;
               }
               var _loc1_:class_1812 = _window.findChildByName("poll_question_answer_container") as class_1812;
               switch(var_775.questionType - 1)
               {
                  case 0:
                     populateRadionButtonType(null,var_775.questionChoices);
                     break;
                  case 1:
                     populateCheckBoxType(null,var_775.questionChoices);
                     break;
                  case 2:
                     populateTextLineType(null);
                     break;
                  case 3:
                     populateTextAreaType(null);
                     break;
                  default:
                     nextQuestion();
               }
               var _loc4_:IItemListWindow = _window.findChildByName("poll_content_wrapper") as IItemListWindow;
               if(_loc4_ != null)
               {
                  var _loc3_:int = null.scrollableRegion.height - null.visibleRegion.height;
                  _window.height += 0;
                  _window.center();
               }
            }
         }
         else
         {
            var_16.pollFinished(var_197);
         }
      }
      
      private function getNextQuestion() : class_3757
      {
         var _loc1_:class_3757 = null;
         var _loc3_:int = 0;
         var _loc2_:class_3757 = null;
         if(var_3036 && var_2606 >= 0 && var_1508 != 0)
         {
            _loc1_ = var_1237[var_2606];
            _loc3_ = 0;
            while(_loc3_ < _loc1_.children.length)
            {
               _loc2_ = _loc1_.children[_loc3_];
               if(_loc2_ && _loc2_.questionCategory == var_1508)
               {
                  var_2606 = -1;
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         var_431 = var_431 + 1;
         if(var_431 < var_1237.length)
         {
            var_2606 = var_431;
            return var_1237[var_431];
         }
         return null;
      }
      
      private function populateRadionButtonType(param1:class_1812, param2:Vector.<class_3851>) : void
      {
         var _loc3_:XmlAsset = var_16.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_radiobutton_input\"!");
         }
         var _loc4_:class_1812 = var_16.windowManager.buildFromXML(_loc3_.content as XML) as class_1812;
         if(_loc4_ != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveRadionButtonTypeAnswer(param1:class_3757) : Array
      {
         var _loc3_:ISelectorWindow = null;
         var _loc4_:ISelectableWindow = null;
         var _loc5_:class_3851 = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            _loc3_ = _window.findChildByName("poll_answer_selector") as ISelectorWindow;
            if(_loc3_)
            {
               _loc4_ = _loc3_.getSelected();
               if(_loc4_)
               {
                  _loc5_ = param1.questionChoices[_loc4_.id];
                  if(var_3036)
                  {
                     var_1508 = _loc5_.choiceType;
                  }
                  else
                  {
                     var_1508 = 0;
                  }
                  _loc2_.push(_loc5_.value);
               }
            }
         }
         return _loc2_;
      }
      
      private function populateCheckBoxType(param1:class_1812, param2:Vector.<class_3851>) : void
      {
         var _loc3_:XmlAsset = var_16.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_checkbox_input\"!");
         }
         var _loc4_:class_1812 = var_16.windowManager.buildFromXML(_loc3_.content as XML) as class_1812;
         if(_loc4_ != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveCheckBoxTypeAnswer(param1:class_3757) : Array
      {
         var _loc5_:IItemListWindow = null;
         var _loc3_:int = 0;
         var _loc6_:class_1812 = null;
         var _loc4_:class_1885 = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            _loc5_ = _window.findChildByName("poll_answer_itemlist") as IItemListWindow;
            if(_loc5_ != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.numListItems)
               {
                  _loc6_ = _loc5_.getListItemAt(_loc3_) as class_1812;
                  if(_loc6_ != null)
                  {
                     _loc4_ = _loc6_.findChildByName("poll_answer_checkbox") as class_1885;
                     if(_loc4_ != null)
                     {
                        if(_loc4_.testStateFlag(8))
                        {
                           _loc2_.push(param1.questionChoices[_loc3_].value);
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
         return _loc2_;
      }
      
      private function populateSelectionList(param1:Vector.<class_3851>, param2:class_1812) : void
      {
         var _loc7_:class_1812 = null;
         var _loc4_:int = 0;
         var _loc5_:ITextWindow = null;
         var _loc3_:class_1741 = null;
         var _loc6_:IItemListWindow = param2.findChildByName("poll_answer_itemlist") as IItemListWindow;
         if(_loc6_ != null)
         {
            _loc7_ = param2.findChildByName("poll_answer_entity") as class_1812;
            if(_loc7_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < param1.length - 1)
               {
                  _loc4_++;
                  _loc6_.addListItem(_loc7_.clone());
               }
               _loc4_ = 0;
               while(_loc4_ < param1.length)
               {
                  _loc7_ = _loc6_.getListItemAt(_loc4_) as class_1812;
                  _loc5_ = _loc7_.findChildByName("poll_answer_entity_text") as ITextWindow;
                  if(_loc5_)
                  {
                     _loc5_.text = param1[_loc4_].choiceText;
                  }
                  _loc3_ = _loc7_.findChildByTag("POLL_SELECTABLE_ITEM");
                  if(_loc3_)
                  {
                     _loc3_.id = _loc4_;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function populateTextLineType(param1:class_1812) : void
      {
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("poll_answer_text_input") as XmlAsset;
         if(!_loc2_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_text_input\"!");
         }
         param1.addChild(var_16.windowManager.buildFromXML(_loc2_.content as XML));
      }
      
      private function resolveTextLineTypeAnswer() : Array
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:Array = [];
         if(_window != null)
         {
            _loc2_ = _window.findChildByName("poll_answer_input") as ITextWindow;
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.text);
            }
            return _loc1_;
         }
         throw new Error("Invalid or disposed poll dialog!");
      }
      
      private function populateTextAreaType(param1:class_1812) : void
      {
         populateTextLineType(param1);
      }
      
      private function resolveTextAreaTypeAnswer() : Array
      {
         return resolveTextLineTypeAnswer();
      }
      
      private function cancelPoll() : void
      {
         var_16.pollCancelled(var_197);
      }
      
      private function answerPollQuestion() : void
      {
         var answerArray:Array;
         var answers:Array;
         var message:RoomWidgetPollMessage;
         var answerValue:int;
         var question:class_3757 = null;
         if(var_3036 && var_775)
         {
            question = var_775;
         }
         else
         {
            question = var_1237[var_431];
         }
         var_1508 = 0;
         switch(question.questionType - 1)
         {
            case 0:
               answerArray = resolveRadionButtonTypeAnswer(question);
               break;
            case 1:
               answerArray = resolveCheckBoxTypeAnswer(question);
               if(answerArray.length < 0)
               {
                  var_16.windowManager.alert("${win_error}","${poll_alert_answer_missing}",0,function(param1:class_1750, param2:class_1758):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               if(answerArray.length > question.questionChoices.length)
               {
                  var_16.windowManager.alert("${win_error}","${poll_alert_invalid_selection}",0,function(param1:class_1750, param2:class_1758):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               break;
            case 2:
               answerArray = resolveTextLineTypeAnswer();
               break;
            case 3:
               answerArray = resolveTextAreaTypeAnswer();
               break;
            default:
               throw new Error("Unknown poll question type: " + question.questionType + "!");
         }
         answers = [];
         message = new RoomWidgetPollMessage("RWPM_ANSWER",var_197);
         message.questionId = question.questionId;
         if(question.questionChoices.length > 0)
         {
            for each(answerValue in answerArray)
            {
               answers.push(answerValue);
            }
         }
         else
         {
            answers.push(answerArray);
         }
         message.answers = answers;
         var_16.messageListener.processWidgetMessage(message);
         nextQuestion();
      }
      
      private function showCancelConfirm() : void
      {
         var _loc4_:XmlAsset = null;
         if(!var_512)
         {
            _loc4_ = var_16.assets.getAssetByName("poll_cancel_confirm") as XmlAsset;
            var_512 = var_16.windowManager.buildFromXML(_loc4_.content as XML,2) as class_2250;
            var_512.center();
            var _loc2_:class_1741 = var_512.findChildByName("header_button_close");
            var _loc3_:class_1741 = var_512.findChildByName("poll_cancel_confirm_button_ok");
            var _loc1_:class_1741 = var_512.findChildByName("poll_cancel_confirm_button_cancel");
         }
      }
      
      private function hideCancelConfirm() : void
      {
         if(var_512 != null)
         {
            var_512.dispose();
            var_512 = null;
         }
      }
      
      private function onCancelPollClose(param1:class_1758) : void
      {
         hideCancelConfirm();
      }
      
      private function onCancelPollOk(param1:class_1758) : void
      {
         hideCancelConfirm();
         cancelPoll();
      }
      
      private function onCancelPollCancel(param1:class_1758) : void
      {
         hideCancelConfirm();
      }
      
      private function answerableQuestionCount() : void
      {
         var_2424 = var_1237.length;
         for each(var _loc1_ in var_1237)
         {
            if(_loc1_.children.length > 0)
            {
               var_2424 = var_2424 + 1;
            }
         }
      }
   }
}

