package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DesktopController extends ActivatorController implements class_2052, class_1970
   {
      
      public function DesktopController(param1:String, param2:WindowContext, param3:Rectangle)
      {
         super(param1,0,0,0,param2,param3,null,defaultProcedure,null,null,0);
      }
      
      public function get mouseX() : int
      {
         return getDisplayObject().stage.mouseX;
      }
      
      public function get mouseY() : int
      {
         return getDisplayObject().stage.mouseY;
      }
      
      override public function set parent(param1:class_1741) : void
      {
         throw new Error("Desktop window doesn\'t have parent!");
      }
      
      override public function set procedure(param1:Function) : void
      {
         var_962 = param1 ?? defaultProcedure;
      }
      
      override public function get host() : class_1741
      {
         return this;
      }
      
      override public function get desktop() : class_2052
      {
         return this;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_43)
         {
            var_43 = new GraphicContext("GC {" + _name + "}",256,rectangle);
            GraphicContext(var_43).mouseEnabled = true;
            GraphicContext(var_43).doubleClickEnabled = true;
         }
         return var_43;
      }
      
      public function getActiveWindow() : class_1741
      {
         return getActiveChild();
      }
      
      public function setActiveWindow(param1:class_1741) : class_1741
      {
         return setActiveChild(param1);
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getGraphicContext(true) as DisplayObject;
      }
      
      public function setDisplayObject(param1:DisplayObject) : void
      {
         getGraphicContext(true).setDisplayObject(param1);
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      private function defaultProcedure(param1:class_1758, param2:class_1741) : void
      {
      }
   }
}

