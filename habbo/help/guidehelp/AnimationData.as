package com.sulake.habbo.help.guidehelp
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public class AnimationData
   {
      
      public var window:IStaticBitmapWrapperWindow;
      
      public var asset:String;
      
      public var frameCount:int;
      
      public function AnimationData(param1:IStaticBitmapWrapperWindow, param2:String, param3:int)
      {
         super();
         this.window = param1;
         this.asset = param2;
         this.frameCount = param3;
      }
   }
}

