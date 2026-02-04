package com.sulake.habbo.help
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.parser.help.class_2617;
   import com.sulake.habbo.communication.messages.parser.help.class_2624;
   import com.sulake.habbo.window.utils.IModalDialog;
   import package_2.class_3251;
   import package_2.class_3458;
   import package_34.class_2524;
   import package_34.class_3552;
   
   public class HabboWayQuizController implements class_13
   {
      
      private static const HABBO_WAY_QUIZ_CODE:String = "HabboWay1";
      
      private static const SAFETY_QUIZ_CODE:String = "SafetyQuiz1";
      
      private static const PAGE_QUESTION:int = 1;
      
      private static const PAGE_SUCCESS:int = 2;
      
      private static const PAGE_FAILURE:int = 3;
      
      private static const PAGE_ANALYSIS:int = 4;
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var var_393:IModalDialog;
      
      private var _window:class_1812;
      
      private var var_2302:class_1812;
      
      private var var_788:ISelectorListWindow;
      
      private var var_1588:ISelectableWindow;
      
      private var var_1006:IItemListWindow;
      
      private var var_1785:class_1741;
      
      private var var_1366:String;
      
      private var var_1965:Array;
      
      private var var_1790:Array;
      
      private var _answerOrders:Array;
      
      private var _questionIdsForWrongAnswers:Array;
      
      private var var_775:int;
      
      public function HabboWayQuizController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_3251(onQuizData));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_3458(onQuizResults));
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_2302 = null;
            var_788 = null;
            if(var_1588 != null)
            {
               var_1588.dispose();
               var_1588 = null;
            }
            var_1006 = null;
            if(var_1785 != null)
            {
               var_1785.dispose();
               var_1785 = null;
            }
            closeWindow();
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showHabboWayQuiz() : void
      {
         _habboHelp.sendMessage(new class_3552("HabboWay1"));
      }
      
      public function showSafetyQuiz() : void
      {
         _habboHelp.sendMessage(new class_3552("SafetyQuiz1"));
      }
      
      private function onQuizData(param1:class_3251) : void
      {
         var _loc2_:class_2617 = param1.getParser();
         _habboHelp.closeHabboWay();
         _habboHelp.closeSafetyBooklet();
         showWindow(_loc2_.quizCode,_loc2_.questionIds);
      }
      
      private function onQuizResults(param1:class_3458) : void
      {
         var _loc2_:class_2624 = param1.getParser();
         _questionIdsForWrongAnswers = _loc2_.questionIdsForWrongAnswers;
         if(_questionIdsForWrongAnswers.length == 0)
         {
            showPage(2);
         }
         else
         {
            showPage(3);
         }
      }
      
      private function showWindow(param1:String, param2:Array) : void
      {
         closeWindow();
         var_393 = _habboHelp.getModalXmlWindow("habbo_way_quiz");
         _window = class_1812(var_393.rootWindow);
         _window.procedure = onWindowEvent;
         var_2302 = class_1812(_window.findChildByName("question_pane"));
         var_788 = ISelectorListWindow(var_2302.findChildByName("answer_list"));
         var_1588 = var_788.getSelectableAt(0);
         var_788.removeSelectable(var_1588);
         var_1006 = IItemListWindow(_window.findChildByName("analysis_pane"));
         var_1785 = var_1006.getListItemAt(0);
         var_1006.removeListItems();
         var_1006.spacing = 4;
         var_1366 = param1;
         var_1965 = param2;
         var_1790 = new Array(questionCount);
         _answerOrders = new Array(questionCount);
         setCurrentQuestion(0);
         var _loc3_:class_1812 = class_1812(IItemListWindow(var_1785).getListItemByName("explanation_container"));
         switch(var_1366)
         {
            case "HabboWay1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}habboway/quiz_question.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "help_habboway_dove_on";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}habboway/quiz_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "help_habboway_dove_quizz";
               break;
            case "SafetyQuiz1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}safetyquiz/question_illustration.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("failure_illustration")).assetUri = "${image.library.url}safetyquiz/result_failure.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}safetyquiz/result_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
         }
         showPage(1);
      }
      
      private function closeWindow() : void
      {
         _window = null;
         if(var_393 != null)
         {
            var_393.dispose();
            var_393 = null;
         }
      }
      
      private function showPage(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:IItemListWindow = null;
         var _loc6_:String = null;
         var _loc9_:String = null;
         _window.findChildByName("question_pane").visible = param1 == 1;
         _window.findChildByName("success_pane").visible = param1 == 2;
         _window.findChildByName("failure_pane").visible = param1 == 3;
         var_1006.visible = param1 == 4;
         _window.findChildByName("prev_next_buttons").visible = param1 == 1;
         _window.findChildByName("failure_buttons").visible = param1 == 3;
         _window.findChildByName("exit_button_container").visible = param1 == 2 || param1 == 4;
         var _loc3_:class_1741 = _window.findChildByName("top_indicator");
         var _loc7_:class_1741 = _window.findChildByName("indicator_image");
         switch(param1 - 1)
         {
            case 0:
               _window.caption = getFullLocalizationKey("question.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",1,"page_count",questionCount.toString());
               _loc3_.caption = getFullLocalizationKey("question.page");
               break;
            case 1:
               _window.caption = getFullLocalizationKey("success.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("success_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("success.results"),"","question_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 2:
               _loc5_ = var_1965.length - _questionIdsForWrongAnswers.length;
               _window.caption = getFullLocalizationKey("failure.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("failure_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("failure.results"),"","correct_count",_loc5_.toString(),"total_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 3:
               _window.caption = getFullLocalizationKey("analysis.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = getFullLocalizationKey("analysis.top");
               for each(var _loc4_ in _questionIdsForWrongAnswers)
               {
                  _loc2_ = int(var_1790[var_1965.indexOf(_loc4_)]);
                  _loc8_ = IItemListWindow(var_1785.clone());
                  _loc6_ = "${quiz." + var_1366 + ".";
                  _loc9_ = "." + _loc4_ + "." + _loc2_ + "}";
                  _loc8_.getListItemByName("question").caption = _loc6_ + "question." + _loc4_ + "}";
                  class_1812(_loc8_.getListItemByName("answer_container")).findChildByName("answer").caption = _loc6_ + "answer" + _loc9_;
                  class_1812(_loc8_.getListItemByName("explanation_container")).findChildByName("explanation").caption = _loc6_ + "explanation" + _loc9_;
                  var_1006.addListItem(_loc8_);
               }
               IItemListWindow(var_1006.getListItemAt(var_1006.numListItems - 1)).getListItemByName("separator").dispose();
         }
      }
      
      private function onWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(_disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2 is ISelectableWindow)
         {
            var_1790[var_775] = int(param2.name);
            _window.findChildByName("next_dimmer").visible = false;
         }
         else
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "exit_button":
                  closeWindow();
                  break;
               case "prev_button":
                  setCurrentQuestion(var_775 - 1);
                  break;
               case "next_button":
                  setCurrentQuestion(var_775 + 1);
                  break;
               case "review_button":
                  showPage(4);
            }
         }
      }
      
      private function setCurrentQuestion(param1:int) : void
      {
         if(param1 >= questionCount)
         {
            _habboHelp.sendMessage(new class_2524(var_1366,var_1790));
         }
         else if(param1 >= 0)
         {
            var_775 = param1;
            _window.findChildByName("prev_dimmer").visible = param1 <= 0;
            _window.findChildByName("next_dimmer").visible = var_1790[var_775] == null;
            _window.findChildByName("top_indicator").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",String(param1 + 1),"page_count",questionCount.toString());
            while(var_788.numSelectables > 0)
            {
               var_788.removeSelectable(var_788.getSelectableAt(0)).dispose();
            }
            var _loc3_:int = int(var_1965[var_775]);
            var _loc10_:Array = [];
            var_2302.findChildByName("question").caption = "${quiz." + var_1366 + ".question." + 0 + "}";
            var _loc2_:int = 0;
            while(true)
            {
               var _loc4_:String = _habboHelp.localization.getLocalization("quiz." + var_1366 + ".answer." + 0 + "." + 0,"");
               if(_loc4_.length <= 0)
               {
                  break;
               }
               var _loc6_:ISelectableWindow = ISelectableWindow(var_1588.clone());
               _loc6_.caption = null;
               null.name = (0).toString();
               null.push(null);
               _loc2_++;
            }
            if(_answerOrders[var_775] == null)
            {
               _answerOrders[var_775] = [];
               var _loc7_:int = 0;
            }
            else
            {
               for each(var _loc8_ in _answerOrders[var_775])
               {
                  var_788.addSelectable(null[_loc8_]);
               }
            }
            var _loc9_:ISelectableWindow = var_788.getSelectableByName(String(var_1790[var_775]));
            if(_loc9_ != null)
            {
               null.select();
            }
         }
      }
      
      private function get questionCount() : int
      {
         return var_1965 != null ? var_1965.length : 0;
      }
      
      private function getFullLocalizationKey(param1:String) : String
      {
         return "${" + getRawLocalizationKey(param1) + "}";
      }
      
      private function getRawLocalizationKey(param1:String) : String
      {
         var _loc2_:String = var_1366;
         if("HabboWay1" !== _loc2_)
         {
            return "quiz." + var_1366 + "." + param1;
         }
         return "habbo.way.quiz." + param1;
      }
   }
}

