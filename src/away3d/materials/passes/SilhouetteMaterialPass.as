package away3d.materials.passes
{
	import away3d.arcane;
	import away3d.cameras.Camera3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.materials.MaterialBase;
	import flash.display3D.Context3DCompareMode;
	
	use namespace arcane;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SilhouetteMaterialPass extends DefaultScreenPass
	{
		/**
		 * Creates a new SilhouetteMaterialPass objects.
		 */
		public function SilhouetteMaterialPass(material:MaterialBase)
		{
			super(material);
			_depthCompareMode = Context3DCompareMode.GREATER;
		}
		
		override arcane function activate(stage3DProxy:Stage3DProxy, camera:Camera3D, textureRatioX:Number, textureRatioY:Number):void
		{
			super.activate(stage3DProxy, camera, textureRatioX, textureRatioY);
			stage3DProxy._context3D.setDepthTest(false, _depthCompareMode);
		}
	
	}

}