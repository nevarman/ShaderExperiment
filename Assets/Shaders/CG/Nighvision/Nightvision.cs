using UnityEngine;
using System.Collections;
[ExecuteInEditMode]
[AddComponentMenu("Image Effects/Vision/NightVision")]
public class Nightvision : MonoBehaviour {

	public delegate void OnNightVisionEnabledDelegate(bool enabled);
	public static event OnNightVisionEnabledDelegate onNightVisionEnabled;

	public Shader shader;
	public Texture2D _NoiseTex;
	public Texture2D _MaskTex;
	[Range(0f,1f)]
	public float _LuminanceThreshold= 0.3f;
	[Range(2f,20f)]
	public float _ColorAmplification= 6.0f;
	[Range(0.1f,1f)]
	public float _LightTreshold = 0.2f;
	[Range(0f,8f)]
	public float _Zoom = 0f;

	private Material m_Material;

	void OnEnable()
	{
		if(onNightVisionEnabled!=null)onNightVisionEnabled(true);
	}

	protected virtual void Start ()
	{
		// Disable if we don't support image effects
		if (!SystemInfo.supportsImageEffects) {
			enabled = false;
			return;
		}
		if(shader == null)shader = Shader.Find("Hidden/NightVision");
		// Disable the image effect if the shader can't
		// run on the users graphics card
		if (!shader || !shader.isSupported)
			enabled = false;
	}
	
	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material (shader);
				m_Material.hideFlags = HideFlags.HideAndDontSave;
			}
			return m_Material;
		} 
	}
	
	protected virtual void OnDisable() {
		if( m_Material ) {
			DestroyImmediate( m_Material );
		}
		if(onNightVisionEnabled!=null)onNightVisionEnabled(false);
	}
	void OnRenderImage (RenderTexture source, RenderTexture destination) {
		material.SetTexture("_NoiseTex", _NoiseTex);
		material.SetTexture("_MaskTex", _MaskTex);
		material.SetFloat("_LuminanceThreshold",_LuminanceThreshold);
		material.SetFloat("_ColorAmplification",_ColorAmplification);
		material.SetFloat("_LightTreshold",_LightTreshold);
		material.SetFloat("_Zoom",_Zoom);
		Graphics.Blit (source, destination, material);
	}
}
