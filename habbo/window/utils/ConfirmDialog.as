package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.window.class_38;
   
   public class ConfirmDialog extends AlertDialog implements class_2001
   {
      
      public function ConfirmDialog(param1:class_38, param2:XML, param3:String, param4:String, param5:uint, param6:Function, param7:Boolean)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function dialogEventProc(param1:class_1758, param2:class_1741) : void
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
                  }
                  break;
               case "_alert_button_cancel":
               case "header_button_close":
                  if(_callback != null)
                  {
                     _loc3_ = class_1758.allocate("WE_CANCEL",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
            }
         }
      }
   }
}

