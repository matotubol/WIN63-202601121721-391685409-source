package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class IlluminaInputWidget implements IIlluminaInputWidget
   {
      
      public static const TYPE:String = "illumina_input";
      
      private static const const_1067:String = "illumina_input:button_caption";
      
      private static const const_823:String = "illumina_input:empty_message";
      
      private static const MULTILINE_KEY:String = "illumina_input:multiline";
      
      private static const MAX_CHARS_KEY:String = "illumina_input:max_chars";
      
      private static const SINGLE_LINE_HEIGHT:int = 28;
      
      private static const BUTTON_CAPTION_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:button_caption","${widgets.chatinput.say}","String");
      
      private static const EMPTY_MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:empty_message","","String");
      
      private static const MULTILINE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:multiline",false,"Boolean");
      
      private static const MAX_CHARS_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:max_chars",0,"int");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _submitButton:class_1775;
      
      private var var_33:ITextFieldWindow;
      
      private var _emptyMessageLabel:ILabelWindow;
      
      private var var_3264:IIlluminaInputHandler;
      
      public function IlluminaInputWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_input_xml").content as XML) as class_1812;
         var_134.width = var_210.width;
         _submitButton = var_134.findChildByName("submit") as class_1775;
         var_33 = var_134.findChildByName("input") as ITextFieldWindow;
         _emptyMessageLabel = var_134.findChildByName("empty_message") as ILabelWindow;
         buttonCaption = String(BUTTON_CAPTION_DEFAULT.value);
         emptyMessage = String(EMPTY_MESSAGE_DEFAULT.value);
         multiline = Boolean(MULTILINE_DEFAULT.value);
         maxChars = int(MAX_CHARS_DEFAULT.value);
         refresh();
         var_134.procedure = widgetProcedure;
         var_210.rootWindow = var_134;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_33 != null)
            {
               var_33 = null;
            }
            _submitButton = null;
            _emptyMessageLabel = null;
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(BUTTON_CAPTION_DEFAULT.withValue(buttonCaption));
         _loc1_.push(EMPTY_MESSAGE_DEFAULT.withValue(emptyMessage));
         _loc1_.push(MULTILINE_DEFAULT.withValue(multiline));
         _loc1_.push(MAX_CHARS_DEFAULT.withValue(maxChars));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_input:button_caption":
                  buttonCaption = String(_loc2_.value);
                  break;
               case "illumina_input:empty_message":
                  emptyMessage = String(_loc2_.value);
                  break;
               case "illumina_input:multiline":
                  multiline = Boolean(_loc2_.value);
                  break;
               case "illumina_input:max_chars":
                  maxChars = int(_loc2_.value);
            }
         }
      }
      
      public function get buttonCaption() : String
      {
         return _submitButton.caption;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         _submitButton.caption = param1;
         _submitButton.visible = param1 != null && param1.length > 0;
         refresh();
      }
      
      public function get emptyMessage() : String
      {
         return _emptyMessageLabel.caption;
      }
      
      public function set emptyMessage(param1:String) : void
      {
         _emptyMessageLabel.caption = param1;
      }
      
      public function get multiline() : Boolean
      {
         return var_33.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         var_33.multiline = param1;
         var_134.setParamFlag(2048,param1);
         var_134.height = param1 ? var_210.height : 28;
      }
      
      public function get maxChars() : int
      {
         return var_33.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         var_33.maxChars = param1;
      }
      
      public function get message() : String
      {
         return var_33.caption;
      }
      
      public function set message(param1:String) : void
      {
         var_33.caption = param1;
         refresh();
      }
      
      public function get submitHandler() : IIlluminaInputHandler
      {
         return var_3264;
      }
      
      public function set submitHandler(param1:IIlluminaInputHandler) : void
      {
         var_3264 = param1;
      }
      
      private function widgetProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WE_CHANGE":
               if(param2 == var_33)
               {
                  refresh();
               }
               break;
            case "WKE_KEY_DOWN":
               if(param2 == var_33 && WindowKeyboardEvent(param1).charCode == 13 && Boolean(_submitButton.visible))
               {
                  submitMessage();
               }
               break;
            case "WME_CLICK":
               if(param2 == _submitButton)
               {
                  submitMessage();
               }
         }
      }
      
      private function submitMessage() : void
      {
         if(var_3264 != null)
         {
            var_3264.onInput(var_210,message);
         }
      }
      
      private function refresh() : void
      {
         _emptyMessageLabel.visible = var_33.length == 0;
         var_33.width = (_submitButton.visible ? _submitButton.x : int(var_134.width)) - var_33.x * 2;
      }
   }
}

