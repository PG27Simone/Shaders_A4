using UnityEngine;

public class LightOscillator : MonoBehaviour
{
    public float angleRange = 45f;
    public float speed = 1f;       

    private Quaternion startRotation;

    void Start()
    {
        startRotation = transform.localRotation;
    }

    void Update()
    {
        float angle = Mathf.Sin(Time.time * speed) * (angleRange / 2f);
        transform.localRotation = startRotation * Quaternion.Euler(angle, 0, 0);
    }
}