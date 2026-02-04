package com.sulake.habbo.navigator.view.search
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class SearchView
   {
      
      private static const INPUT_PLACEHOLDER_TEXTCOLOR:uint = 10461087;
      
      private static const INPUT_TEXTCOLOR:uint = 0;
      
      private static var FILTER_SELECTOR_INDEX_TO_MODE:Array = [5,2,1,3,4];
      
      private static var FILTER_MODE_TO_SELECTOR_INDEX:Array = [0,2,1,3,4,0];
      
      private var _navigator:HabboNewNavigator;
      
      private var _container:class_1812;
      
      private var var_33:ITextFieldWindow;
      
      private var var_2343:class_2261;
      
      private var var_1946:String;
      
      public function SearchView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         var_1946 = _navigator.localization.getLocalizationWithParams("navigator.filter.input.placeholder","filter rooms by...");
      }
      
      public function set container(param1:class_1812) : void
      {
         _container = param1;
         var_2343 = class_2261(_container.findChildByName("filter_type_drop_menu"));
         var_33 = ITextFieldWindow(_container.findChildByName("search_input"));
         var_33.addEventListener("WKE_KEY_UP",keyUpHandler);
         var_33.addEventListener("WE_CHANGE",onInputChanged);
         var_33.addEventListener("WE_FOCUSED",onInputFocused);
         var _loc2_:class_1741 = _container.findChildByName("clear_search_button");
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_CLICK",onClearSearch);
         }
         clear();
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         var_33.focus();
         var_33.caption = "";
         var _loc2_:IStaticBitmapWrapperWindow = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc2_.assetUri = "common_small_pen";
      }
      
      public function clear() : void
      {
         setInputToFilterPlaceHolder();
         var_2343.selection = 0;
         _container.findChildByName("refreshButtonContainer").visible = false;
      }
      
      public function setTextAndSearchModeFromFilter(param1:String, param2:String = "") : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc3_:int = class_3893.filterInInput(param1);
         if(_loc3_ != 0)
         {
            var_2343.selection = FILTER_MODE_TO_SELECTOR_INDEX[_loc3_];
            var_33.caption = param1.substr(class_3893.FILTER_PREFIX[_loc3_].length,param1.length - class_3893.FILTER_PREFIX[_loc3_].length);
         }
         else
         {
            var_33.caption = param1;
            var_2343.selection = 0;
         }
         if(param2 != "" && param2 != var_1946)
         {
            var_33.caption = param2;
            setInputFieldTextFormattingToPlaceholder(true);
         }
         else if(var_33.caption == "")
         {
            setInputToFilterPlaceHolder();
         }
         else
         {
            setInputFieldTextFormattingToPlaceholder(false);
         }
         if(var_33.caption.length != 0 && var_33.caption != var_1946)
         {
            _container.findChildByName("refreshButtonContainer").visible = true;
            _loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = "icons_close";
         }
         else
         {
            _container.findChildByName("refreshButtonContainer").visible = false;
            _loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = "common_small_pen";
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            _navigator.performSearch(_navigator.currentResults.searchCodeOriginal,getFilterParameter());
         }
      }
      
      private function getFilterParameter() : String
      {
         return class_3893.FILTER_PREFIX[FILTER_SELECTOR_INDEX_TO_MODE[var_2343.selection]] + var_33.caption;
      }
      
      private function setInputToFilterPlaceHolder() : void
      {
         setInputFieldTextFormattingToPlaceholder(true);
         var_33.caption = var_1946;
      }
      
      private function onInputFocused(param1:class_1758) : void
      {
         setInputFieldTextFormattingToPlaceholder(false);
         if(var_33.caption == var_1946)
         {
            var_33.caption = "";
         }
      }
      
      private function setInputFieldTextFormattingToPlaceholder(param1:Boolean) : void
      {
         var_33.textColor = param1 ? 10461087 : 0;
         var_33.italic = param1;
      }
      
      private function onInputChanged(param1:class_1758) : void
      {
      }
      
      public function get currentInput() : String
      {
         if(var_33 != null)
         {
            return var_33.caption;
         }
         return var_1946;
      }
   }
}

