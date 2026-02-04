package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class SimpleAlertDialog implements class_13
   {
      
      private static const WINDOW_MARGIN:int = 10;
      
      private var _disposed:Boolean;
      
      private var var_393:IModalDialog;
      
      private var var_989:String;
      
      private var _window:class_1812;
      
      private var var_121:IItemListWindow;
      
      private var var_1454:IItemListWindow;
      
      private var var_2638:IItemListWindow;
      
      private var var_3132:class_1741;
      
      private var var_1654:class_1741;
      
      private var var_777:ITextLinkWindow;
      
      private var var_689:IStaticBitmapWrapperWindow;
      
      private var var_2525:Function;
      
      private var var_2421:Function;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      public function SimpleAlertDialog(param1:HabboWindowManagerComponent, param2:String, param3:String, param4:String, param5:String, param6:String, param7:class_55, param8:String, param9:Function, param10:Function)
      {
         super();
         var_2525 = param9;
         var_2421 = param10;
         _windowManager = param1;
         var _loc14_:IAsset = param1.assets.getAssetByName("simple_alert_xml");
         var_393 = param1.buildModalDialogFromXML(_loc14_.content as XML);
         _window = class_1812(var_393.rootWindow);
         var_121 = IItemListWindow(_window.findChildByName("list"));
         var_1454 = IItemListWindow(_window.findChildByName("list_top"));
         var_2638 = IItemListWindow(_window.findChildByName("list_bottom"));
         var_3132 = _window.findChildByName("message");
         var_1654 = _window.findChildByName("subtitle");
         var_777 = ITextLinkWindow(_window.findChildByName("link"));
         var_689 = IStaticBitmapWrapperWindow(_window.findChildByName("illustration"));
         _window.findChildByName("header_button_close").dispose();
         _window.procedure = windowProcedure;
         _window.caption = param2;
         var_3132.caption = param4;
         if(param7 != null)
         {
            for each(var _loc13_ in [param2,param3,param4,param5])
            {
               if(_loc13_ != null && _loc13_.substr(0,2) == "${" && _loc13_.indexOf("}") > 0)
               {
                  var _loc12_:String = _loc13_.substring(2,_loc13_.indexOf("}"));
                  for(var _loc11_ in param7)
                  {
                     param1.localization.registerParameter(null,_loc11_,param7.getValue(_loc11_));
                  }
               }
            }
         }
         if(param3 != null && param3 != "")
         {
            var_1654.caption = param3;
         }
         else
         {
            var_1654.dispose();
            var_1654 = null;
         }
         param6 = param1.interpolate(param6);
         if(param5 != null && param5 != "" && (param6 != null && param6 != "" || param9 != null))
         {
            var_777.caption = param5;
            var_777.addEventListener("WME_CLICK",onSimpleAlertClick);
            var_777.immediateClickMode = true;
            var_989 = param6;
         }
         else
         {
            var_777.dispose();
            var_777 = null;
         }
         if(param8 != null && param8 != "")
         {
            var_689.addEventListener("WE_RESIZED",onIllustrationResized);
            var_689.assetUri = param8;
         }
         else
         {
            var_689.dispose();
            var_689 = null;
         }
         resizeWindow();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            close();
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function close() : void
      {
         if(var_2421 != null)
         {
            var_2421();
         }
         if(var_393 != null)
         {
            if(var_777 != null)
            {
               var_777.removeEventListener("WME_CLICK",onSimpleAlertClick);
               var_777 = null;
            }
            if(var_689)
            {
               var_689.removeEventListener("WE_RESIZED",onIllustrationResized);
               var_689 = null;
            }
            _window = null;
            var_121 = null;
            var_1454 = null;
            var_2638 = null;
            var_3132 = null;
            var_1654 = null;
            var_2525 = null;
            var_2421 = null;
            var_393.dispose();
            var_393 = null;
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "close_button")
         {
            dispose();
         }
      }
      
      private function onSimpleAlertClick(param1:WindowMouseEvent) : void
      {
         if(var_989 != null && var_989.length > 0)
         {
            if(var_989.substr(0,6) == "event:")
            {
               _windowManager.context.createLinkEvent(var_989.substr(6));
               dispose();
            }
            else
            {
               HabboWebTools.openWebPage(var_989,"habboMain");
            }
         }
         else if(var_2525 != null)
         {
            var_2525();
            dispose();
         }
      }
      
      private function onIllustrationResized(param1:class_1758) : void
      {
         var_1454.x = var_689.width + 10;
         var_2638.width = var_1454.right;
         _window.width = var_1454.right + 2 * 10;
         var_1454.limits.minHeight = var_689.height + 10;
         resizeWindow();
      }
      
      private function resizeWindow() : void
      {
         var_1454.arrangeListItems();
         var_2638.arrangeListItems();
         var_121.arrangeListItems();
         _window.height = var_121.height + 40;
         _window.center();
      }
   }
}

