package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowTouchEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class ButtonController extends InteractiveController implements class_1775, ITouchAwareWindow
   {
      
      protected static const TEXT_FIELD_NAME:String = "_BTN_TEXT";
      
      protected static const CAPTION_BLEND_CHANGE:Number = 0.5;
      
      public function ButtonController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 131072;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:class_1741 = getChildByName("_BTN_TEXT");
         if(_loc2_ != null)
         {
            _loc2_.caption = caption;
         }
      }
      
      override public function set blend(param1:Number) : void
      {
         super.blend = param1;
         var _loc3_:class_1741 = getChildByName("_BTN_TEXT");
         var _loc2_:Boolean = getStateFlag(32);
         if(_loc3_ != null)
         {
            _loc3_.blend = _loc2_ ? param1 / 2 : param1;
         }
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc5_:String = null;
         var _loc4_:class_1758 = null;
         var _loc3_:Boolean = false;
         if(param2 is class_1758)
         {
            switch(param2.type)
            {
               case "WE_CHILD_RESIZED":
                  width = 0;
                  break;
               case "WE_ENABLED":
                  try
                  {
                     getChildByName("_BTN_TEXT").blend = getChildByName("_BTN_TEXT").blend + 0.5;
                     break;
                  }
                  catch(e:Error)
                  {
                     break;
                  }
                  break;
               case "WE_DISABLED":
                  try
                  {
                     getChildByName("_BTN_TEXT").blend = getChildByName("_BTN_TEXT").blend - 0.5;
                  }
                  catch(e:Error)
                  {
                  }
            }
         }
         else if(param2 is WindowTouchEvent)
         {
            _loc5_ = "";
            switch(param2.type)
            {
               case "WTE_BEGIN":
                  _loc5_ = "WME_DOWN";
                  break;
               case "WTE_END":
                  _loc5_ = "WME_UP";
                  break;
               case "WTE_TAP":
                  _loc5_ = "WME_CLICK";
            }
            _loc4_ = WindowMouseEvent.allocate(_loc5_,WindowTouchEvent(param2).window,WindowTouchEvent(param2).related,WindowTouchEvent(param2).localX,WindowTouchEvent(param2).localY,WindowTouchEvent(param2).stageX,WindowTouchEvent(param2).stageY,WindowTouchEvent(param2).altKey,WindowTouchEvent(param2).ctrlKey,WindowTouchEvent(param2).shiftKey,true,0);
            _loc3_ = super.update(param1,_loc4_);
            _loc4_.recycle();
            return _loc3_;
         }
         return super.update(param1,param2);
      }
   }
}

