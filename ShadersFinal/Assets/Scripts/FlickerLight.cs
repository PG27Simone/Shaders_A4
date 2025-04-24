using UnityEngine;

public class FlickerLight : MonoBehaviour
{
    public Light lightSource;
    public float minIntensity = 0.5f;
    public float maxIntensity = 1.5f;
    public float flickerSpeed = 0.1f;

    void Start() => InvokeRepeating(nameof(Flicker), 0f, flickerSpeed);

    void Flicker() => lightSource.intensity = Random.Range(minIntensity, maxIntensity);
}
