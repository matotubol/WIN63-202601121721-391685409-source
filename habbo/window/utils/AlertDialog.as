package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2675;
   import com.sulake.habbo.window.class_38;
   
   public class AlertDialog implements class_1750, INotify
   {
      
      protected static const LIST_BUTTONS:String = "_alert_button_list";
      
      protected static const const_210:String = "_alert_button_ok";
      
      protected static const const_131:String = "_alert_button_cancel";
      
      protected static const BUTTON_CUSTOM:String = "_alert_button_custom";
      
      protected static const const_598:String = "header_button_close";
      
      protected static const const_479:String = "_alert_text_summary";
      
      private static var var_493:uint = 0;
      
      protected var var_839:String = "";
      
      protected var var_2854:String = "";
      
      protected var _disposed:Boolean = false;
      
      protected var _callback:Function = null;
      
      protected var _window:class_2250;
      
      protected var var_393:IModalDialog;
      
      public function AlertDialog(param1:class_38, param2:XML, param3:String, param4:String, param5:uint, param6:Function, param7:Boolean)
      {
         super();
         var_493 = var_493 + 1;
         if(param7)
         {
            var_393 = param1.buildModalDialogFromXML(param2);
            _window = var_393.rootWindow as class_2250;
         }
         else
         {
            _window = param1.buildFromXML(param2,2) as class_2250;
         }
         if(param5 == 0)
         {
            param5 = uint(0x10 | 1 | 2);
         }
         var _loc9_:IItemListWindow = _window.findChildByName("_alert_button_list") as IItemListWindow;
         if(_loc9_)
         {
            if(!(param5 & 0x10))
            {
               var _loc8_:class_1741 = _loc9_.getListItemByName("_alert_button_ok");
               _loc8_.dispose();
            }
            if(!(param5 & 0x20))
            {
               _loc8_ = _loc9_.getListItemByName("_alert_button_cancel");
               _loc8_.dispose();
            }
            if(!(param5 & 0x40))
            {
               _loc8_ = _loc9_.getListItemByName("_alert_button_custom");
               _loc8_.dispose();
            }
         }
         _window.procedure = dialogEventProc;
         _window.center();
         this.title = param3;
         this.summary = param4;
         this.callback = param6;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_393 && !var_393.disposed)
            {
               var_393.dispose();
               var_393 = null;
               _window = null;
            }
            if(_window && !_window.disposed)
            {
               _window.dispose();
               _window = null;
            }
            _callback = null;
            _disposed = true;
         }
      }
      
      protected function dialogEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:class_1758 = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "_alert_button_ok":
                  if(_callback != null)
                  {
                     _loc3_ = class_1758.allocate("WE_OK",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                     break;
                  }
                  dispose();
                  break;
               case "header_button_close":
               case "_alert_button_cancel":
                  if(_callback != null)
                  {
                     _loc3_ = class_1758.allocate("WE_CANCEL",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                     break;
                  }
                  dispose();
            }
         }
      }
      
      public function getButtonCaption(param1:int) : class_2675
      {
         var _loc2_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc2_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc2_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc2_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         return _loc2_ ? new AlertDialogCaption(_loc2_.caption,_loc2_.toolTipCaption,_loc2_.visible) : null;
      }
      
      public function setButtonCaption(param1:int, param2:class_2675) : void
      {
         var _loc3_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc3_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc3_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc3_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         if(_loc3_)
         {
            _loc3_.caption = param2.text;
         }
      }
      
      public function set title(param1:String) : void
      {
         var_839 = param1;
         if(_window)
         {
            _window.caption = var_839;
         }
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function set summary(param1:String) : void
      {
         var_2854 = param1;
         if(_window)
         {
            ITextWindow(_window.findChildByTag("DESCRIPTION")).text = var_2854;
         }
      }
      
      public function get summary() : String
      {
         return var_2854;
      }
      
      public function set titleBarColor(param1:uint) : void
      {
         if(!_window)
         {
            return;
         }
         _window.color = param1;
      }
      
      public function get titleBarColor() : uint
      {
         if(!_window)
         {
            return 0;
         }
         return _window.color;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

